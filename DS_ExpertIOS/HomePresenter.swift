//
//  MainPresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 04/03/24.
//

import Foundation
import Combine
import DsCoreIos

class HomePresenter: BasePresenter {
  
  private let homeUseCase: HomeUseCase
  let homeRouter = HomeRouter()
  
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func clearGames() {
    self.games.removeAll()
  }
  
  func getAllGames() {
    loadingState = true
    errorMessage = ""
    
    homeUseCase.getAllGames()
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
    homeUseCase.startDownloadImage(game: game)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: RunLoop.main)
      .sink { _ in
        completion()
      }
      .store(in: &cancellables)
  }
 
}
