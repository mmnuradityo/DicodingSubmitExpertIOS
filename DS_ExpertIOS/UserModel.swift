//
//  UserModel.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

struct UserModel {
  let firstName: String
  let lastName: String
  let avatar: Data?
  let description: String
  let address: String
  
  func fullName() -> String {
    return lastName.isEmpty ? firstName : "\(firstName) \(lastName)"
  }
}
