//
//  HomeInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getAllGames() -> AnyPublisher<[GameModel], Error>
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never>
}

class HomeInteractor: HomeUseCase {
  
  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getAllGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getAllGames()
  }
  
  func startDownloadImage(game: GameModel) -> AnyPublisher<GameModel, Never> {
    return repository.startDownloadImage(game: game)
  }
  
}
