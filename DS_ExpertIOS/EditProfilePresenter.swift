//
//  EditProfilePresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation
import DSCore
import DSBase

class EditProfilePresenter: BasePresenter {
  
  private let editUseCase: EditProfileUseCase
  
  @Published var userModel: UserModel?
  
  init(editUseCase: EditProfileUseCase) {
    self.editUseCase = editUseCase
  }
  
  func getUser() {
    self.userModel = editUseCase.getUser()
  }
  
  func updateUser(userModel: UserModel) {
    editUseCase.updateUser(user: userModel)
  }
  
}
