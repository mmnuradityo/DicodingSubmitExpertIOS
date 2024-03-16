//
//  Filter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

struct Filters: Codable {
  
  var years: [Years]?
  
  enum CodingKeys: String, CodingKey {
    case years
  }
}

struct Years: Codable {
  
  var from: Int?
  var to: Int?
  var filter: String?
  var decade: Int?
  var years: [Year]?
  var nofollow: Bool?
  var count: Int?
  
  enum CodingKeys: String, CodingKey {
    case from
    case to
    case filter
    case decade
    case years
    case nofollow
    case count
  }
  
}

struct Year: Codable {
  
  var year: Int?
  var count: Int?
  var nofollow: Bool?
  
  enum CodingKeys: String, CodingKey {
    case year
    case count
    case nofollow
  }
  
}
