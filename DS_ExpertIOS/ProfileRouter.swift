//
//  ProfileRouter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import UIKit
import DSCore

class ProfileRouter {
  
  func makeEditProfileViewController() -> UINavigationController {
    let useCase = Injection().provideEditProfileUseCase()
    let editPresenter = EditProfilePresenter(editUseCase: useCase)
    let editViewController = EditProfileViewController(presenter: editPresenter)
    
    let viewController = UINavigationController(rootViewController: editViewController)
    viewController.modalPresentationStyle = .fullScreen
    return viewController
  }
  
}
