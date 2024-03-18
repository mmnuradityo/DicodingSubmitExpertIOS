//
//  MainTabBar.swift
//  DS_ExpertIOS
//
//  Created by Admin on 21/01/24.
//

import UIKit
import DSCore

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
    viewControllers = [
      router.makeHomeViewController(),
      router.makeFavoriteViewController(),
      router.makeProfileViewController()
    ]
  }
}
