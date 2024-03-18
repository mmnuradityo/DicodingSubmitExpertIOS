//
//  DetailPresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import Combine
import DSCore
import DSBase

class DetailPresenter: BasePresenter {
  
  private let detailUseCase: DetailUseCase
  
  @Published var game: GameModel?
  @Published var errorMessage: String = ""
  
  init(detailUseCase: DetailUseCase, game: GameModel?) {
    self.detailUseCase = detailUseCase
    self.game = game
  }
  
  func getGamesDetail() {
    guard let game = game else { return }
    self.errorMessage = ""
    
    detailUseCase.getGamesDetail(id: game.id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished: break
        }
      }, receiveValue: { game in
        self.updateGame(game: game)
      })
      .store(in: &cancellables)
  }
  
  func updateFavorite(completion: @escaping (GameModel) -> Void) {
    guard let game = game else { return }
    self.errorMessage = ""
    
    detailUseCase.updateGamesFaforite(game: game)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished: break
        }
      }, receiveValue: { game in
        self.updateGame(game: game)
        completion(game)
      })
      .store(in: &cancellables)
  }
  
  private func updateGame(game: GameModel) {
    if let currentGame = self.game {
      game.configre(image: currentGame.image, state: currentGame.state)
    }
    self.game = game
  }
  
  func startDownloadImage() {
    guard let game = game else { return }
    
    detailUseCase.startDownloadImage(game: game)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: RunLoop.main)
      .sink { game in
        self.game = game
      }
      .store(in: &cancellables)
  }
}
