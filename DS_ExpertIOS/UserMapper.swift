//
//  UserMapper.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

class UserMapper {
  
  static func entityToModel(entity: UserEntity) -> UserModel {
    return UserModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      avatar: entity.avatar,
      description: entity.description,
      address: entity.address
    )
  }
  
}
