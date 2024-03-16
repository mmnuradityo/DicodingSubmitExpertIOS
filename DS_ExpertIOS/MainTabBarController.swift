//
//  MainTabBar.swift
//  DS_ExpertIOS
//
//  Created by Admin on 21/01/24.
//

import UIKit
import DsCoreIos

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestNotification()
    setupView()
  }
  
  private func requestNotification() {
    let notificationUtils = NotificationUtils()
    notificationUtils.setup()
    notificationUtils.requestNotif {
      // ignored
    }
  }
  
  private func setupView() {
    let router = MainRouter()
    var viewControllerList: [UIViewController] = []
    
    if let homeViewController = router.makeHomeViewController() {
      viewControllerList.append(homeViewController)
    }
    if let favoriteViewController = router.makeFavoriteViewController() {
      viewControllerList.append(favoriteViewController)
    }
    if let profileViewController = router.makeProfileViewController() {
      viewControllerList.append(profileViewController)
    }
    viewControllers = viewControllerList
  }
}
