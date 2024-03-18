//
//  FavoriteItemView.swift
//  DS_ExpertIOS
//
//  Created by Admin on 22/02/24.
//

import SwiftUI
import DSCore

struct FavoriteItemView: View {
  var game: GameModel
  
  var body: some View {
    HStack {
      ZStack {
        Image(systemName: "heart.fill")
          .frame(width: 32, height: 32)
          .scaledToFit()
          .foregroundColor(Color.red)
          .background(Color.white)
          .clipShape(Circle())
          .background(
            Circle()
              .stroke(Color.red, lineWidth: 2)
          )
      }
      .frame(maxWidth: 130, maxHeight: 130, alignment: .bottomTrailing) // << here !!
      .background(FavoriteImageView(game: game))
      .padding([.leading, .top])
      
      VStack(spacing: 2) {
        Text(game.title)
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity, alignment: .topLeading)
          .font(.system(.title3, design: .default))
        
        Spacer(minLength: 8)
        
        HStack {
          Text("Release Date:")
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.system(.caption, design: .default))
          
          Text(DateUtils.getDateString(date: game.releaseDate))
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .font(.system(.caption, design: .default))
        }
        
        Divider()
        
        HStack {
          Text("Rating")
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.system(.caption, design: .default))
          
          Text(game.rating.description)
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .font(.system(.caption, design: .default))
        }
        
        Spacer(minLength: 32)
      }
      .padding([.trailing, .bottom, .top])
    }
    .frame(height: 132)
    .padding([.bottom, .top], 6)
  }
}

struct FavoriteItemView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteItemView(game: GameModel(
      id: 0,
      title: "Apaan tuh",
      rating: 0.0,
      releaseDate: DateUtils.generateDate(dateString: "2024-02-22"),
      posterPath: "https://images.unsplash.com/photo-1608229191360-7064b0afa639?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=100&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTcwODYxNzg4MQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=100"
    ))
  }
}
