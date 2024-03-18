//
//  SearchViewBar.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import UIKit
import DSCore

public protocol SearchViewBarDelegate: NSObjectProtocol {
  func onShowSearchBar()
  func onHideSearchBar()
}

public class SearchViewBar: NSObject {
  
  private let presenter: SearchPresenter
  
  let searchBar = UISearchBar()
  let cancelSearchButton = UIBarButtonItem()
  let searchButton = UIBarButtonItem()
  weak open var delegate: SearchViewBarDelegate?
  
  var isFavorite = false
  var isSearchActivated = false
  
  init(presenter: SearchPresenter) {
    self.presenter = presenter
  }
  
  func setStyle() {
    searchButton.title = "Search"
    searchButton.image = UIImage(systemName: "search")
    searchButton.action = #selector(showSearchBar)
    searchButton.target = self
    
    cancelSearchButton.title = "Cancel"
    cancelSearchButton.action = #selector(hideSearchBar)
    cancelSearchButton.target = self
    
    searchBar.searchBarStyle = UISearchBar.Style.default
    searchBar.placeholder = " Search Games..."
    searchBar.sizeToFit()
    searchBar.delegate = self
  }
  
  func showOrHideSearchBar(isShow: Bool) {
    _ = searchBar.endEditing(!isShow)
    searchBar.removeFromSuperview()
    
    if !isShow {
      searchBar.text = ""
      delegate?.onHideSearchBar()
    } else {
      delegate?.onShowSearchBar()
    }
    
    isSearchActivated = isShow
  }
  
  func loadSearch() {
    guard let searchText = searchBar.text else { return }
    
    if isFavorite {
      presenter.searchFavoriteGames(name: searchText)
    } else {
      presenter.searchGames(name: searchText)
    }
  }
  
  func observe(complation: @escaping ([GameModel]?, Bool?, String?) -> Void) {
    presenter.$games.sink { games in
      if self.isSearchActivated {
        complation(games, nil, nil)
      }
    }.store(in: &presenter.cancellables)
    
    presenter.$loadingState.sink { state in
      if self.isSearchActivated {
        complation(nil, state, nil)
      }
    }.store(in: &presenter.cancellables)
    
    presenter.$errorMessage.sink { error in
      if self.isSearchActivated {
        complation(nil, nil, error)
      }
    }.store(in: &presenter.cancellables)
    
  }
}

extension SearchViewBar: UISearchBarDelegate {
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    presenter.prepareForSearch()
    
    NSObject.cancelPreviousPerformRequests(
      withTarget: self, selector: #selector(runSearch), object: nil
    )
    perform(#selector(runSearch), with: nil, afterDelay: 1)
  }
}

extension SearchViewBar {
  @objc func runSearch() {
    loadSearch()
  }
  
  @objc func showSearchBar(sender: UIBarButtonItem) {
    showOrHideSearchBar(isShow: true)
  }
  
  @objc func hideSearchBar(sender: UIBarButtonItem) {
    showOrHideSearchBar(isShow: false)
  }
}
