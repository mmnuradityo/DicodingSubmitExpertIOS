//
//  MainPresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 04/03/24.
//

import Foundation
import Combine
import DSCore
import DSBase

class HomePresenter: BaseListPresenter<GameModel, HomeUseCase> {
  
  let homeRouter = HomeRouter()
  
  func clearGames() {
    self.games.removeAll()
  }
  
  func getAllGames() {
    loadingState = true
    errorMessage = ""
    
    useCase.getAllGames()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { games in
        self.addOrUpdateGames(games: games)
      })
      .store(in: &cancellables)
  }
  
  private func addOrUpdateGames(games: [GameModel]) {
    if self.games.isEmpty {
      self.games = games
      
    } else {
      var game: GameModel
      
      for index in 0 ..< self.games.count {
        game = self.games[index]
        
        for newGame in games where game.id == newGame.id {
          game.isFavorite = newGame.isFavorite
          self.games.remove(at: index)
          self.games.insert(game, at: index)
          break
        }
      }
    }
  }
  
  func startDownloadImage(game: GameModel, completion: @escaping () -> Void) {
    useCase.startDownloadImage(game: game)
      .receive(on: RunLoop.main)
      .sink { _ in
        completion()
      }
      .store(in: &cancellables)
  }
 
}
