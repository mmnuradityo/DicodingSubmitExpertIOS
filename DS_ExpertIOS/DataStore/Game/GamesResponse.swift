//
//  GamesResponse.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

struct GamesResponse: Codable {
  
  var count: Int?
  var next: String?
  var previous: String?
  var results: [Results]?
  var seoTitle: String?
  var seoDescription: String?
  var seoKeywords: String?
  var seoH1: String?
  var noindex: Bool?
  var nofollow: Bool?
  var description: String?
  var filters: Filters?
  var nofollowCollections: [String]?
  
  enum CodingKeys: String, CodingKey {
    case count
    case next
    case previous
    case results
    case seoTitle = "seo_title"
    case seoDescription = "seo_description"
    case seoKeywords = "seo_keywords"
    case seoH1 = "seo_h1"
    case noindex
    case nofollow
    case description
    case filters
    case nofollowCollections = "nofollow_collections"
    
  }
}
