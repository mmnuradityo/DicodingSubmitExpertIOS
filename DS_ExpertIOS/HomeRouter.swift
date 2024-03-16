//
//  HomeRouter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import UIKit
import Cleanse

class HomeRouter {
  
  func makeDetailView(game: GameModel) -> UIViewController? {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      let useCase = inject.provideDetailUseCase()
      let presenter = DetailPresenter(detailUseCase: useCase, game: game)
      let detailViewController = DetailViewController(presenter: presenter)
      
      let viewController = UINavigationController(rootViewController: detailViewController)
      viewController.modalPresentationStyle = .fullScreen
      return viewController
    }
    
    return nil
  }
  
}
