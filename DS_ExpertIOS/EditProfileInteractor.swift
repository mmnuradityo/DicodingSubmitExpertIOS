//
//  EditProfileInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import DSCore
import DSBase

protocol EditProfileUseCase: ProfileUseCase {
  func updateUser(user: UserModel)
}

class EdoitProfileInteractor: BaseInteractor<GameRepositoryProtocol>, EditProfileUseCase {
  
  func getUser() -> UserModel {
    return repository.getUser()
  }
  
  func updateUser(user: UserModel) {
    repository.updateUser(user: user)
  }
}
