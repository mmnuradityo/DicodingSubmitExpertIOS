//
//  InjectionModule.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import Foundation
import Cleanse
import DsCoreIos

struct NetworkServiceModule: Module {
  static func configure(binder: Cleanse.Binder<Cleanse.Unscoped>) {
    binder.bind(NetworkServiceProtocol.self)
      .to(value: NetworkService.init())
  }
}

struct ImageDownloaderModule: Module {
  static func configure(binder: Cleanse.Binder<Cleanse.Unscoped>) {
    binder.bind(ImageDownloaderProtocol.self)
      .to(value: ImageDownloader.init())
  }
}

struct LocalDataBaseModule: Module {
  static func configure(binder: Cleanse.Binder<Cleanse.Unscoped>) {
    binder.bind(FavoriteGameLocalDataBaseProtocol.self)
      .to(value: FavoriteGameLocalDataBaseProvider.init())
  }
}

struct ImageUtilsModule: Module {
  static func configure(binder: Cleanse.Binder<Cleanse.Unscoped>) {
    binder.bind(ImageUtils.self)
      .to(value: ImageUtilsImplementation.init())
  }
}

struct GameRepositoryModule: Module {
  static func configure(binder: Cleanse.Binder<Cleanse.Singleton>) {
    binder.include(module: NetworkServiceModule.self)
    binder.include(module: ImageDownloaderModule.self)
    binder.include(module: LocalDataBaseModule.self)
    binder.install(dependency: UserEntityComponent.self)
    
    binder.bind(GameRepositoryInstaller.self)
      .sharedInScope()
      .to(factory: GameRepositoryInstaller.init)
  }
}
