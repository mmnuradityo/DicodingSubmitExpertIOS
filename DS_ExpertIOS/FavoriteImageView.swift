//
//  FavoriteImageView.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import SwiftUI
import DSCore

struct FavoriteImageView: View {
  var game: GameModel
  
  var body: some View {
    ZStack {
      if game.state == .downloaded,
         let image = game.image,
         let dataImege = UIImage(data: image) {
        
        Image(uiImage: dataImege)
          .resizable()
          .scaledToFill()
        
      } else {
        AsyncImage(url: URL(string: game.posterPath)) { image in
          self.saveAndLoadImage(image: image)
            .resizable()
            .scaledToFill()
          
        } placeholder: {
          ProgressView()
        }
      }
    }
    .frame(width: 120, height: 120)
    .cornerRadius(10)
    .padding([.bottom, .trailing])
    
  }
  
  func saveAndLoadImage(image: Image) -> Image {
    self.game.configre(image: image.asUIImage().pngData(), state: .downloaded)
    return image
  }
}
