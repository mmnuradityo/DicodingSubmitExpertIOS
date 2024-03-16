//
//  EditProfileInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

protocol EditProfileUseCase: ProfileUseCase {
  func updateUser(user: UserModel)
}

class EdoitProfileInteractor: EditProfileUseCase {
  private let repository: GameRepositoryProtocol
  
  init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getUser() -> UserModel {
    return repository.getUser()
  }
  
  func updateUser(user: UserModel) {
    repository.updateUser(user: user)
  }
}
