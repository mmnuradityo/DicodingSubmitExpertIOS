//
//  Results.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

struct Results: Codable {
  var id: Int?
  var slug: String?
  var name: String?
  var released: String?
  var tba: Bool?
  var backgroundImage: String?
  var rating: Double?
  var ratingTop: Int?
  var ratings: [Ratings]?
  var ratingsCount: Int?
  var reviewsTextCount: Int?
  var added: Int?
  var addedByStatus: AddedByStatus?
  var metacritic: Int?
  var playtime: Int?
  var suggestionsCount: Int?
  var updated: String?
  var userGame: String?
  var reviewsCount: Int?
  var saturatedColor: String?
  var dominantColor: String?
  var platforms: [Platforms]?
  var parentPlatforms: [ParentPlatforms]?
  var genres: [Genres]?
  var stores: [Stores]?
  var clip: String?
  var tags: [Tags]?
  var esrbRating: EsrbRating?
  var shortScreenshots: [ShortScreenshots]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case slug
    case name
    case released
    case tba
    case backgroundImage = "background_image"
    case rating
    case ratingTop = "rating_top"
    case ratings
    case ratingsCount = "ratings_count"
    case reviewsTextCount = "reviews_text_count"
    case added
    case addedByStatus = "added_by_status"
    case metacritic
    case playtime
    case suggestionsCount = "suggestions_count"
    case updated
    case userGame = "user_game"
    case reviewsCount = "reviews_count"
    case saturatedColor = "saturated_color"
    case dominantColor = "dominant_color"
    case platforms
    case parentPlatforms = "parent_platforms"
    case genres
    case stores
    case clip
    case tags
    case esrbRating = "esrb_rating"
    case shortScreenshots = "short_screenshots"
  }
}

struct ShortScreenshots: Codable {
  var id: Int?
  var image: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case image
  }
}

struct Ratings: Codable {
  var id: Int?
  var title: String?
  var count: Int?
  var percent: Double?
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case count
    case percent
  }
}

struct AddedByStatus: Codable {
  var yet: Int?
  var owned: Int?
  var beaten: Int?
  var toplay: Int?
  var dropped: Int?
  var playing: Int?
  
  enum CodingKeys: String, CodingKey {
    case yet
    case owned
    case beaten
    case toplay
    case dropped
    case playing
  }
}

struct EsrbRating: Codable {
  var id: Int?
  var name: String?
  var slug: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
  }
}

struct Tags: Codable {
  var id: Int?
  var name: String?
  var slug: String?
  var language: String?
  var gamesCount: Int?
  var imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
    case language
    case gamesCount = "games_count"
    case imageBackground = "image_background"
  }
}

struct Stores: Codable {
  var id: Int?
  var store: Store?
  
  enum CodingKeys: String, CodingKey {
    case id
    case store
  }
}

struct Store: Codable {
  var id: Int?
  var name: String?
  var slug: String?
  var domain: String?
  var gamesCount: Int?
  var imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
    case domain
    case gamesCount = "games_count"
    case imageBackground = "image_background"
  }
}

struct Genres: Codable {
  var id: Int?
  var name: String?
  var slug: String?
  var gamesCount: Int?
  var imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
    case gamesCount = "games_count"
    case imageBackground = "image_background"
  }
}

struct ParentPlatforms: Codable {
  var platform: Platform?
  
  enum CodingKeys: String, CodingKey {
    case platform
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    platform = try values.decodeIfPresent(Platform.self, forKey: .platform)
  }
}

struct Platform: Codable {
  var id: Int?
  var name: String?
  var slug: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
  }
}

struct Platforms: Codable {
  var platform: Platform?
  var releasedAt: String?
  var requirementsEn: Requirements?
  var requirementsRu: Requirements?
  
  enum CodingKeys: String, CodingKey {
    case platform
    case releasedAt = "released_at"
    case requirementsEn = "requirements_en"
    case requirementsRu = "requirements_ru"
  }
}

struct Requirements: Codable {
  var minimum: String?
  var recommended: String?
  
  enum CodingKeys: String, CodingKey {
    case minimum
    case recommended
  }
}
