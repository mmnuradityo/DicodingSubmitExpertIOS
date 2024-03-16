//
//  GameEntity.swift
//  DS_ExpertIOS
//
//  Created by Admin on 05/03/24.
//

import Foundation

struct GameEntity {
  
  let id: Int
  var title: String
  var rating: Double
  var releaseDate: String
  var posterPath: String
  var description: String
  var genre: String
  var reviewsCount: Int
  var isFavorite: Bool
  
  init(
    id: Int,
    title: String,
    rating: Double,
    releaseDate: String,
    posterPath: String,
    description: String = "",
    genre: String = "",
    reviewsCount: Int = 0,
    isFavorite: Bool = false
  ) {
    self.id = id
    self.title = title
    self.rating = rating
    self.releaseDate = releaseDate
    self.posterPath = posterPath
    self.description = description
    self.genre = genre
    self.reviewsCount = reviewsCount
    self.isFavorite = isFavorite
  }
}
