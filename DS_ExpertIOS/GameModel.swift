//
//  Game.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

class GameModel: Identifiable, Equatable {
  static func == (lhs: GameModel, rhs: GameModel) -> Bool {
    return lhs.id == rhs.id
  }
  
  let id: Int
  let title: String
  let rating: Double
  let releaseDate: Date?
  let posterPath: String
  var description: String
  var genre: String
  var reviewsCount: Int
  
  var image: Data?
  var state: DownloadState = .new
  var isFavorite = false
  
  init(
    id: Int,
    title: String,
    rating: Double,
    releaseDate: Date?,
    posterPath: String,
    description: String = "",
    genre: String = "-",
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
  
  func set(
    description: String,
    genre: String,
    reviewsCount: Int
  ) {
    self.description = description
    self.genre = genre
    self.reviewsCount = reviewsCount
  }
  
  func configre(
    image: Data?,
    state: DownloadState
  ) {
    self.image = image
    self.state = state
  }
}
