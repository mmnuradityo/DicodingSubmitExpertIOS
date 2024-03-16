//
//  MainPreseter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 04/03/24.
//

import Foundation
import Cleanse

class Injection: NSObject {
  
  let repository: Provider<GameRepositoryProtocol>
  
  init(repository: Provider<GameRepositoryProtocol>) {
    self.repository = repository
  }

  func provideHomeUseCase() -> HomeUseCase {
    return HomeInteractor(repository: repository.get())
  }
  
  func provideDetailUseCase() -> DetailUseCase {
    return DetailInteractor(repository: repository.get())
  }
  
  func provideProfileUseCase() -> ProfileUseCase {
    return ProfileInteractor(repository: repository.get())
  }
  
  func provideEditProfileUseCase() -> EditProfileUseCase {
    return EdoitProfileInteractor(repository: repository.get())
  }
  
  func provideFavoriteUseCase() -> FavoriteUseCase {
    return FavoriteInteractor(repository: repository.get())
  }
  
  func provideSearchUseCase() -> SearchUseCase {
    return SearchInteractor(repository: repository.get())
  }
}
