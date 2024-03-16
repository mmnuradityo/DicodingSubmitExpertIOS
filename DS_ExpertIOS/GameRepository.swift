//
//  DataManager.swift
//  DS_ExpertIOS
//
//  Created by Admin on 24/02/24.
//

import Combine
import Cleanse
import Foundation

protocol GameRepositoryProtocol {
  func getAllGames() -> AnyPublisher<[GameModel], Error>
  func getAllGamesFavorite() -> AnyPublisher<[GameModel], Error>
  func getGamesDetail(id: Int) -> AnyPublisher<GameModel, Error>
  func updateGamesDetail(game: GameModel) -> AnyPublisher<GameModel, Error>
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never>
  func searchGames(name: String) -> AnyPublisher<[GameModel], Error>
  func searchFavoriteGames(name: String) -> AnyPublisher<[GameModel], Error>
  func getUser() -> UserModel
  func updateUser(user: UserModel)
}

class GameRepository: NSObject {
  
  fileprivate let networkService: NetworkServiceProtocol
  fileprivate let imageDownloader: ImageDownloaderProtocol
  fileprivate let localDB: FavoriteGameLocalDataBaseProtocol
  fileprivate var userEntity: UserEntity
  
  init(
    networkService: NetworkServiceProtocol,
    imageDownloader: ImageDownloaderProtocol,
    localDB: FavoriteGameLocalDataBaseProtocol,
    userEntity: ComponentFactory<UserEntityComponent>
  ) {
    self.networkService = networkService
    self.imageDownloader = imageDownloader
    self.localDB = localDB
    self.userEntity = userEntity.build(())
  }
  
}

extension GameRepository: GameRepositoryProtocol {
  func getAllGames() -> AnyPublisher<[GameModel], Error> {
    return localDB.getAll()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.networkService.getGames()
            .map { GameMapper.responseToEntity(response: $0) }
            .flatMap { self.localDB.creates($0) }
            .map { gameEntity in GameMapper.entitiesToModel(entity: gameEntity) }
            .eraseToAnyPublisher()
        }
        
        return Just(result)
          .map { GameMapper.entitiesToModel(entity: $0) }
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
        
      }.eraseToAnyPublisher()
  }
  
  func getAllGamesFavorite() -> AnyPublisher<[GameModel], Error> {
    return getAllGames()
      .map { games in games.filter { $0.isFavorite } }
      .eraseToAnyPublisher()
  }
  
  func getGamesDetail(id: Int) -> AnyPublisher<GameModel, Error> {
    return localDB.get(id: id)
      .flatMap { result -> AnyPublisher<GameModel, Error> in
        if result == nil ||
            result!.reviewsCount == 0
            || result!.genre.isEmpty
            || result!.description.isEmpty {
          return self.networkService.getDetailGame(id: id)
            .map { GameMapper.detailResponseToEntity(response: $0) }
            .flatMap {
              if result == nil {
                return self.localDB.create($0)
                
              } else {
                var entity = $0
                entity.isFavorite = result!.isFavorite
                return self.localDB.update(entity)
              }
            }
            .map { GameMapper.entityToModel(entity: $0) }
            .eraseToAnyPublisher()
        }
        
        return Just(result!)
          .map { GameMapper.entityToModel(entity: $0) }
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
  
  func updateGamesDetail(game: GameModel) -> AnyPublisher<GameModel, Error> {
    return localDB.update(GameMapper.modelToEntity(game: game))
      .map { GameMapper.entityToModel(entity: $0) }
      .eraseToAnyPublisher()
  }
  
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never> {
    func tranform(data: Data?) -> AnyPublisher<GameModel, Never> {
      return Just(data)
        .map {
          game.configre(image: $0, state: $0 != nil ? .downloaded : .failed)
          return game
        }.eraseToAnyPublisher()
    }
    
    if game.state == .new, let url = URL(string: game.posterPath) {
      return imageDownloader.downloadImage(url: url)
        .flatMap { tranform(data: $0) }
        .eraseToAnyPublisher()
    }
    
    return tranform(data: game.image)
  }
  
  func searchGames(name: String) -> AnyPublisher<[GameModel], Error> {
    return localDB.getGameByName(name: name)
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if !result.isEmpty {
          return self.networkService.getGameByName(name: name)
            .map { GameMapper.responseToEntity(response: $0) }
            .flatMap { response -> AnyPublisher<[GameEntity], Error> in
              return self.addOrUpdateBySearch(localDatas: result, remoteDatas: response)
            }
            .map { gameEntity in GameMapper.entitiesToModel(entity: gameEntity) }
            .eraseToAnyPublisher()
        }
        
        return Just(result)
          .map { GameMapper.entitiesToModel(entity: $0) }
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
        
      }.eraseToAnyPublisher()
  }
  
  func addOrUpdateBySearch(
    localDatas: [GameEntity], remoteDatas: [GameEntity]
  ) -> AnyPublisher<[GameEntity], Error> {
    
    var responseEntities = remoteDatas
    var responseToSave: [GameEntity] = []
    var isExist = false
    
    var responseEntity: GameEntity
    var gameEntity: GameEntity
    
    for responseIndex in 0..<responseEntities.count {
      responseEntity = responseEntities[responseIndex]
      
      for index in 0..<localDatas.count {
        gameEntity = localDatas[index]
        
        if responseEntity.id == gameEntity.id {
          responseEntities.remove(at: responseIndex)
          responseEntity.isFavorite = gameEntity.isFavorite
          responseEntities.insert(responseEntity, at: responseIndex)
          isExist = true
          break
        }
        
        if index == localDatas.count - 1 {
          isExist = true
        }
      }
      
      if !isExist {
        responseToSave.append(responseEntity)
      }
    }
    
    if !responseToSave.isEmpty {
      return self.localDB.creates(responseToSave)
    } else {
      return Just(responseEntities)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }
  
  func searchFavoriteGames(name: String) -> AnyPublisher<[GameModel], Error> {
    return localDB.getGameFavoriteByName(name: name)
      .map { GameMapper.entitiesToModel(entity: $0) }
      .eraseToAnyPublisher()
  }
  
  func getUser() -> UserModel {
    return UserMapper.entityToModel(entity: userEntity)
  }
  
  func updateUser(user: UserModel) {
    userEntity.firstName = user.firstName
    userEntity.lastName = user.lastName
    userEntity.address = user.address
    userEntity.avatar = user.avatar
    userEntity.description = user.description
  }
}
