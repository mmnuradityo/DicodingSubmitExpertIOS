//
//  FavoriteInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import Combine
import DSCore
import DSBase

protocol FavoriteUseCase {
  func getAllGamesFavorite() -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: BaseInteractor<GameRepositoryProtocol>, FavoriteUseCase {
  
  func getAllGamesFavorite() -> AnyPublisher<[GameModel], Error> {
    return repository.getAllGamesFavorite()
  }
  
}
