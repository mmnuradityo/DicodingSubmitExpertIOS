//
//  Configuration.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/"
  static let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api_key") as? String
}

enum Endpoints: String {
  case games
  case gameById = "games/"
}

enum HttpCode: Int {
  case SUCCESS = 200
  case NOT_FOUND = 404
  case BAD_REQUEST = 500
}
