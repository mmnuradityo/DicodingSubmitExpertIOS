//
//  SearchPresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import Foundation
import DSCore
import DSBase

class SearchPresenter: BaseListPresenter<GameModel, SearchUseCase> {
  
  func prepareForSearch() {
    loadingState = true
    errorMessage = ""
  }
  
  func searchGames(name: String) {
    useCase.searchGames(name: name)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }
  
  func searchFavoriteGames(name: String) {
    useCase.searchFavoriteGames(name: name)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }
  
}
