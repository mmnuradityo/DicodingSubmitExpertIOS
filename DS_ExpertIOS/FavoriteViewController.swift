//
//  FavoriteViewController.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import SwiftUI
import DSCore
import DSBase
import DSSearch

class FavoriteViewController: UIHostingController<FavoriteListView> {
  private var searchViewBar: SearchViewBar?
  
  init(presenter: FavoritePresenter, searchViewBar: SearchViewBar) {
    let rootView = FavoriteListView(presenter: presenter)
    super.init(rootView: rootView)
    self.searchViewBar = searchViewBar
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rootView.presentViewController = presentViewController
    rootView.validateError = validateError
    
    if let searchViewBar = searchViewBar {
      searchViewBar.isFavorite = true
      searchViewBar.setStyle()
      searchViewBar.delegate = self
      searchViewBar.showOrHideSearchBar(isShow: false)
      navigationItem.rightBarButtonItem = searchViewBar.searchButton
      
      searchViewBar.observeSearch { (games, isLoading, errorMessage) in
        if games != nil {
          self.rootView.setList(games: games!)
        } else if errorMessage != nil {
          self.rootView.setError(errorMessage: errorMessage!)
        } else if isLoading != nil {
          self.rootView.setLoading(isLoading: isLoading!)
        }
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let searchViewBar = searchViewBar, searchViewBar.isSearchActivated {
      searchViewBar.loadSearch()
    }
  }
  
  func presentViewController(game: GameModel) {
    let detailView = rootView.presenter.router.makeDetailView(game: game)
    present(detailView, animated: true)
  }
  
  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension FavoriteViewController: SearchViewBarDelegate {
  func onHideSearchBar() {
    if let searchViewBar = searchViewBar {
      navigationItem.title = "List Favorite Games"
      navigationItem.titleView = nil
      navigationItem.rightBarButtonItem = searchViewBar.searchButton
      
      if searchViewBar.isSearchActivated {
        rootView.loadAllFavoriteGames()
      }
    }
  }
  
  func onShowSearchBar() {
    if let searchViewBar = searchViewBar {
      navigationItem.title = ""
      navigationItem.titleView = searchViewBar.searchBar
      navigationItem.rightBarButtonItem = searchViewBar.cancelSearchButton
    }
  }
  
  func validateError(errorMessage: String) {
    if !errorMessage.isEmpty {
      displayToast(
        errorMessage, width: UIScreen.main.bounds.size.width - 40
      )
    }
  }
}
