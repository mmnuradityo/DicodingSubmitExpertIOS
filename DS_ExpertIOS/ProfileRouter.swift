//
//  ProfileRouter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import UIKit
import Cleanse

class ProfileRouter {
  
  func makeEditProfileViewController() -> UINavigationController? {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      let useCase = inject.provideEditProfileUseCase()
      let editPresenter = EditProfilePresenter(editUseCase: useCase)
      let editViewController = EditProfileViewController(presenter: editPresenter)
      
      let viewController = UINavigationController(rootViewController: editViewController)
      viewController.modalPresentationStyle = .fullScreen
      return viewController
    }
    
    return nil
  }
  
}
