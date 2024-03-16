//
//  ProfilePresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

class ProfilePresenter: BasePresenter {
  private let userCae: ProfileUseCase
  let router = ProfileRouter()
  
  @Published var userModel: UserModel?
  
  init(profileUserCae: ProfileUseCase) {
    self.userCae = profileUserCae
  }
  
  func getUser() {
    self.userModel = userCae.getUser()
  }
}
