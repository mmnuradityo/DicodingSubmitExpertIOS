//
//  MainRouter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import UIKit
import Cleanse

class MainRouter {
  
  func makeSearchViewBar() -> SearchViewBar? {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      let serachUseCase = inject.provideSearchUseCase()
      let searchPresenter = SearchPresenter(searchUseCase: serachUseCase)
      let searchViewBar = SearchViewBar(presenter: searchPresenter)
      return searchViewBar
    }
    
    return nil
  }
  
  func makeHomeViewController() -> UINavigationController? {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      let useCase = inject.provideHomeUseCase()
      let presenter = HomePresenter(homeUseCase: useCase)
      
      if let searchViewBar = makeSearchViewBar() {
        let mainViewController = HomeViewController(
          presenter: presenter, searchViewBar: searchViewBar
        )
        
        let navigationMain = UINavigationController(rootViewController: mainViewController)
        navigationMain.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "play"), tag: 0)
        return navigationMain
      }
    }
    
    return nil
  }
  
  func makeFavoriteViewController() -> UINavigationController? {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      let useCase = inject.provideFavoriteUseCase()
      let favoritePresenter = FavoritePresenter(favoriteUseCase: useCase)
      
      if let searchViewBar = makeSearchViewBar() {
        let favoriteViewController = FavoriteViewController(
          presenter: favoritePresenter, searchViewBar: searchViewBar
        )
        
        let navigationFavorite = UINavigationController(rootViewController: favoriteViewController)
        navigationFavorite.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        return navigationFavorite
      }
    }
    
    return nil
  }
  
  func makeProfileViewController() -> UINavigationController? {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      let useCase = inject.provideProfileUseCase()
      let profilePresenter = ProfilePresenter(profileUserCae: useCase)
      let profileViewController = ProfileViewController(presenter: profilePresenter)
      
      let navigationProfile = UINavigationController(rootViewController: profileViewController)
      navigationProfile.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "person"), tag: 1)
      return navigationProfile
    }
    
    return nil
  }
}
