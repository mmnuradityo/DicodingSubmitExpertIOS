//
//  File.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

class BaseNetworkService {
  func getBaseUrl() -> String {
    return ""
  }
  
  func getApiKey() -> String? {
    return ""
  }
  
  func createUrl(_ path: String) -> String {
    return getBaseUrl() + path
  }
  
  func createRequest(urlPath: String) -> URLComponents {
    let urls = createUrl(urlPath)
    print("urls ios : " + urls)
    
    var components = URLComponents(string: urls)!
    components.queryItems = [
      URLQueryItem(name: "key", value: getApiKey())
    ]
    return components
  }
  
  func loadRequest<T>(url: URL, _ type: T.Type) async -> T? where T: Decodable {
    do {
      let request = URLRequest(url: url)
      
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let response = response as? HTTPURLResponse else { return nil }
      
      if response.statusCode == HttpCode.SUCCESS.rawValue {
        return decodeJSON(type, from: data)
        
      } else {
        fatalError("Error: Can't fetching data with status \(response.statusCode).")
      }
      
    } catch {
      fatalError("Error: connection failed.")
    }
  }
}
