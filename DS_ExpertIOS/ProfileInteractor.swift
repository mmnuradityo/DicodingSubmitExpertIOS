//
//  ProfileInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

protocol ProfileUseCase {
  func getUser() -> UserModel
}

class ProfileInteractor: ProfileUseCase {
  
  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getUser() -> UserModel {
    return repository.getUser()
  }
  
}
