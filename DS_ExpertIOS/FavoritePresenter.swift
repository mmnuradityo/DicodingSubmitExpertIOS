//
//  FavoritePresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

class FavoritePresenter: BasePresenter {
  
  private let favoriteUseCase: FavoriteUseCase
  let router = FavoriteRouter()
  
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func clearGamesFavorite() {
    self.games.removeAll()
  }
  
  func getAllGamesFavorite() {
    self.loadingState = true
    self.errorMessage = ""
    
    favoriteUseCase.getAllGamesFavorite()
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
    if !self.games.isEmpty {
      var game: GameModel
      
      for index in 0 ..< self.games.count {
        game = self.games[index]
        
        for newGame in games where game.id == newGame.id {
          newGame.configre(image: game.image, state: game.state)
          break
        }
      }
    }
    
    self.games = games
  }
  
}
