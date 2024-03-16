//
//  GameDetailResponse.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

struct GameDetailResponse: Codable {
  
  var id: Int?
  var slug: String?
  var name: String?
  var nameOriginal: String?
  var description: String?
  var metacritic: Int?
  var released: String?
  var tba: Bool?
  var updated: String?
  var backgroundImage: String?
  var backgroundImageAdditional: String?
  var website: String?
  var rating: Double?
  var ratingTop: Int?
  var added: Int?
  var playtime: Int?
  var screenshotsCount: Int?
  var moviesCount: Int?
  var creatorsCount: Int?
  var achievementsCount: Int?
  var parentAchievementsCount: Int?
  var redditUrl: String?
  var redditName: String?
  var redditDescription: String?
  var redditLogo: String?
  var redditCount: Int?
  var twitchCount: Int?
  var youtubeCount: Int?
  var reviewsTextCount: Int?
  var ratingsCount: Int?
  var suggestionsCount: Int?
  var alternativeNames: [String]?
  var metacriticUrl: String?
  var parentsCount: Int?
  var additionsCount: Int?
  var gameSeriesCount: Int?
  var userGame: String?
  var reviewsCount: Int?
  var saturatedColor: String?
  var dominantColor: String?
  var clip: String?
  var descriptionRaw: String?
  var genres: [GenreDetails]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case slug
    case name
    case nameOriginal = "name_original"
    case description
    case metacritic
    case released
    case tba
    case updated
    case backgroundImage = "background_image"
    case backgroundImageAdditional = "background_image_additional"
    case website
    case rating
    case ratingTop = "rating_top"
    case added
    case playtime
    case screenshotsCount = "screenshots_count"
    case moviesCount = "movies_count"
    case creatorsCount = "creators_count"
    case achievementsCount = "achievements_count"
    case parentAchievementsCount = "parent_achievements_count"
    case redditUrl = "reddit_url"
    case redditName = "reddit_name"
    case redditDescription = "reddit_description"
    case redditLogo = "reddit_logo"
    case redditCount = "reddit_count"
    case twitchCount = "twitch_count"
    case youtubeCount = "youtube_count"
    case reviewsTextCount = "reviews_text_count"
    case ratingsCount = "ratings_count"
    case suggestionsCount = "suggestions_count"
    case alternativeNames = "alternative_names"
    case metacriticUrl = "metacritic_url"
    case parentsCount = "parents_count"
    case additionsCount = "additions_count"
    case gameSeriesCount = "game_series_count"
    case userGame = "user_game"
    case reviewsCount = "reviews_count"
    case saturatedColor = "saturated_color"
    case dominantColor = "dominant_color"
    case clip
    case descriptionRaw = "description_raw"
    case genres
    
  }
  
}

struct GenreDetails: Codable {
  
  var id: Int?
  var name: String?
  var slug: String?
  var gamesCount: Int?
  var imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
    case gamesCount = "gameas_count"
    case imageBackground = "image_background"
  }
}
