//
//  MainPreseter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 04/03/24.
//

import Foundation
import Cleanse
import DSCore

class Injection: NSObject {
  
  private func getRepository() -> GameRepositoryProtocol {
    do {
      let compoment = try ComponentFactory.of(RepositoryInjectionComponent.self)
      let inject = compoment.build(())
      return inject.getRepository()
    } catch {
      fatalError("Repository is nil!")
    }
  }
  
  func provideHomeUseCase() -> HomeUseCase {
    return HomeInteractor(repository: getRepository())
  }
  
  func provideFavoriteUseCase() -> FavoriteUseCase {
    return FavoriteInteractor(repository: getRepository())
  }
  
}
