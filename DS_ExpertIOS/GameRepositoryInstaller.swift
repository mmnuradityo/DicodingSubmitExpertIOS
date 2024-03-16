//
//  GameRepositoryInstaller.swift
//  DS_ExpertIOS
//
//  Created by Admin on 16/03/24.
//

import Foundation
import DsCoreIos
import Cleanse

class GameRepositoryInstaller {
  
  let repository: GameRepositoryProtocol
  
  init(
    networkService: NetworkServiceProtocol,
       imageDownloader: ImageDownloaderProtocol,
       localDB: FavoriteGameLocalDataBaseProtocol,
       userEntity: ComponentFactory<UserEntityComponent>
  ) {
    self.repository = GameRepository.init(
      networkService: networkService,
      imageDownloader: imageDownloader,
      localDB: localDB,
      userEntity: userEntity.build(())
    )
  }
}
