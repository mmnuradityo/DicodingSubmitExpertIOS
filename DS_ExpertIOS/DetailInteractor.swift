//
//  DetailInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getGamesDetail(id: Int) -> AnyPublisher<GameModel, Error>
  func updateGamesFaforite(game: GameModel) -> AnyPublisher<GameModel, Error>
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never>
}

class DetailInteractor: DetailUseCase {
  
  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGamesDetail(id: Int) -> AnyPublisher<GameModel, Error> {
    return repository.getGamesDetail(id: id)
  }
  
  func updateGamesFaforite(game: GameModel) -> AnyPublisher<GameModel, Error> {
    game.isFavorite = !game.isFavorite
    return repository.updateGamesDetail(game: game)
  }
  
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never> {
    return repository.startDownloadImage(game: game)
  }
}
