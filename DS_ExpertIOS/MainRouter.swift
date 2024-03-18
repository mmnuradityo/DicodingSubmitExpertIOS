//
//  MainRouter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import UIKit
import DSCore
import DSSearch
import DSProfile

public class MainRouter {
  
  public func makeSearchViewBar() -> SearchViewBar {
    return SearchViewBarBuilder().create()
  }
  
  public func makeHomeViewController() -> UINavigationController {
    let useCase =  Injection().provideHomeUseCase()
    let presenter = HomePresenter(useCase: useCase)
    
    let searchViewBar = makeSearchViewBar()
    let mainViewController = HomeViewController(
      presenter: presenter, searchViewBar: searchViewBar
    )
    
    let navigationMain = UINavigationController(rootViewController: mainViewController)
    navigationMain.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "play"), tag: 0)
    return navigationMain
  }
  
  public func makeFavoriteViewController() -> UINavigationController {
    let useCase =  Injection().provideFavoriteUseCase()
    let favoritePresenter = FavoritePresenter(useCase: useCase)
    
    let searchViewBar = makeSearchViewBar()
    let favoriteViewController = FavoriteViewController(
      presenter: favoritePresenter, searchViewBar: searchViewBar
    )
    
    let navigationFavorite = UINavigationController(rootViewController: favoriteViewController)
    navigationFavorite.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
    return navigationFavorite
  }
  
  public func makeProfileViewController() -> UINavigationController {
    let profileViewController = ProfileBuilder().create()
    
    let navigationProfile = UINavigationController(rootViewController: profileViewController)
    navigationProfile.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "person"), tag: 1)
    return navigationProfile
  }
}
