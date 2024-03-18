//
//  HomeInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import Combine
import DSCore
import DSBase

protocol HomeUseCase {
  func getAllGames() -> AnyPublisher<[GameModel], Error>
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never>
}

class HomeInteractor: BaseInteractor<GameRepositoryProtocol>, HomeUseCase {
  
  func getAllGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getAllGames()
  }
  
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never> {
    return repository.startDownloadImage(game: game)
  }
  
}
