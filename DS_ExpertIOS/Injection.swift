//
//  MainPreseter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 04/03/24.
//

import Foundation
import Cleanse
import DsCoreIos

class Injection: NSObject {
  
  let repositoryInataller: Provider<GameRepositoryInstaller>
  
  init(repositoryInataller: Provider<GameRepositoryInstaller>) {
    self.repositoryInataller = repositoryInataller
  }

  func provideHomeUseCase() -> HomeUseCase {
    return HomeInteractor(repository: repositoryInataller.get().repository)
  }
  
  func provideDetailUseCase() -> DetailUseCase {
    return DetailInteractor(repository: repositoryInataller.get().repository)
  }
  
  func provideProfileUseCase() -> ProfileUseCase {
    return ProfileInteractor(repository: repositoryInataller.get().repository)
  }
  
  func provideEditProfileUseCase() -> EditProfileUseCase {
    return EdoitProfileInteractor(repository: repositoryInataller.get().repository)
  }
  
  func provideFavoriteUseCase() -> FavoriteUseCase {
    return FavoriteInteractor(repository: repositoryInataller.get().repository)
  }
  
  func provideSearchUseCase() -> SearchUseCase {
    return SearchInteractor(repository: repositoryInataller.get().repository)
  }
}
