//
//  PersonModel.swift
//  DS_ExpertIOS
//
//  Created by Admin on 21/01/24.
//

import Foundation

private struct UserKey {
  let firstNameKey = "firstNameKey"
  let lastNameKey = "lastNameKey"
  let avatarKey = "avatarKey"
  let descriptionKey = "descriptionKey"
  let addressKey = "DescriptionKey"
}

struct UserEntity {
  private let key = UserKey()
  private let persistent = UserDefaults.standard
  private let imageUtils: ImageUtils
  
  var firstName: String {
    get {
      return persistent.string(forKey: key.firstNameKey) ?? ""
    }
    set {
      persistent.set(newValue, forKey: key.firstNameKey)
    }
  }
  
  var lastName: String {
    get {
      return persistent.string(forKey: key.lastNameKey) ?? ""
    }
    set {
      persistent.set(newValue, forKey: key.lastNameKey)
    }
  }
  
  var avatar: Data? {
    get {
      return persistent.data(forKey: key.avatarKey)
    }
    set {
      persistent.set(newValue, forKey: key.avatarKey)
    }
  }
  
  var description: String {
    get {
      return persistent.string(forKey: key.descriptionKey) ?? ""
    }
    set {
      persistent.set(newValue, forKey: key.descriptionKey)
    }
  }
  
  var address: String {
    get {
      return persistent.string(forKey: key.addressKey) ?? ""
    }
    set {
      persistent.set(newValue, forKey: key.addressKey)
    }
  }
  
  init(imageUtils: ImageUtils) {
    self.imageUtils = imageUtils
    
    if firstName.isEmpty {
      firstName = "M. Miftah"
      lastName = "Nuradityo"
      avatar = imageUtils.getImageData(from: "miftah")
      description = "Belajar coding"
      address = "Yogyakarta"
    }
  }
}
