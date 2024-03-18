//
//  HomeRouter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import UIKit
import DSCore
import DSDetailView

public class HomeRouter {
  
  public func makeDetailView(game: GameModel?) -> UIViewController {
    let detailViewController = DetailViewBuilder().create(game: game)
    
    let viewController = UINavigationController(rootViewController: detailViewController)
    viewController.modalPresentationStyle = .fullScreen
    return viewController
  }
  
}
