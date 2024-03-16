//
//  FavoriteListView.swift
//  DS_ExpertIOS
//
//  Created by Admin on 22/02/24.
//

import SwiftUI

struct FavoriteListView: View {
  @ObservedObject var presenter: FavoritePresenter
  var presentViewController: ((GameModel) -> Void)?
  var isSearchActivated = false
  
  var body: some View {
    VStack(spacing: 0) {
      let _: Void = self.validateError()
      
      if presenter.loadingState {
        ProgressView {
          Text("Loading data...")
        }
        
      } else if presenter.games.isEmpty {
        Text("Empty data")
        
      } else {
        Divider()
        
        List {
          ForEach(presenter.games) { game in
            Button(action: {
              presentViewController?(game)
            }, label: {
              VStack(alignment: .leading, spacing: 0) {
                FavoriteItemView(game: game)
                Divider()
              }
            })
          }
          .listRowSeparator(.hidden)
          .listRowInsets(EdgeInsets())
        }
      }
    }
    .listStyle(.plain)
    .onAppear {
      if !isSearchActivated {
        presenter.getAllGamesFavorite()
      }
    }
  }
  
  func validateError() {
    if !presenter.errorMessage.isEmpty {
      displayToast(
        presenter.errorMessage, width: UIScreen.main.bounds.size.width - 40
      )
    }
  }
  
  mutating func setList(games: [GameModel]) {
    isSearchActivated = true
    presenter.games = games
  }
  
  func setError(errorMessage: String) {
    presenter.errorMessage = errorMessage
  }
  
  func setLoading(isLoading: Bool) {
    presenter.loadingState = isLoading
  }
  
  mutating func loadAllFavoriteGames() {
    isSearchActivated = false
    presenter.clearGamesFavorite()
    presenter.getAllGamesFavorite()
  }
}
