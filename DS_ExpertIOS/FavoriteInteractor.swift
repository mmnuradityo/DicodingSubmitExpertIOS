//
//  FavoriteInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import Combine

protocol FavoriteUseCase {
  func getAllGamesFavorite() -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
  private let repository: GameRepositoryProtocol
  
  init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getAllGamesFavorite() -> AnyPublisher<[GameModel], Error> {
    return repository.getAllGamesFavorite()
  }
  
}
