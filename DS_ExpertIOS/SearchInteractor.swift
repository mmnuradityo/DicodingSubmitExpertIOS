//
//  SearchInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import Foundation
import Combine
import DSCore
import DSBase

protocol SearchUseCase {
  func searchGames(name: String) -> AnyPublisher<[GameModel], Error>
  func searchFavoriteGames(name: String) -> AnyPublisher<[GameModel], Error>
}

class SearchInteractor: BaseInteractor<GameRepositoryProtocol>, SearchUseCase {
  
  func searchGames(name: String) -> AnyPublisher<[GameModel], Error> {
    return repository.searchGames(name: name)
  }
  
  func searchFavoriteGames(name: String) -> AnyPublisher<[GameModel], Error> {
    return repository.searchFavoriteGames(name: name)
  }
}
