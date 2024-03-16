//
//  InjectionComponent.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import Foundation
import Cleanse
import DsCoreIos

struct UserEntityComponent: Component {
  typealias Root = UserEntity
  
  static func configure(binder: Cleanse.Binder<Cleanse.Unscoped>) {
    binder.include(module: ImageUtilsModule.self)
  }
  
  static func configureRoot(binder bind: Cleanse.ReceiptBinder<UserEntity>) -> Cleanse.BindingReceipt<UserEntity> {
    return bind.to(factory: UserEntity.init)
  }
}

struct InjectionComponent: RootComponent {
  typealias Root = Injection
  
  static func configureRoot(binder bind: Cleanse.ReceiptBinder<Injection>) -> Cleanse.BindingReceipt<Injection> {
    return bind.to(factory: Injection.init)
  }
  
  static func configure(binder: Cleanse.Binder<Cleanse.Singleton>) {
    binder.include(module: GameRepositoryModule.self)
  }
}
