//
//  ProfileInteractor.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import DSCore
import DSBase

protocol ProfileUseCase {
  func getUser() -> UserModel
}

class ProfileInteractor: BaseInteractor<GameRepositoryProtocol>, ProfileUseCase {
  
  func getUser() -> UserModel {
    return repository.getUser()
  }
  
}
