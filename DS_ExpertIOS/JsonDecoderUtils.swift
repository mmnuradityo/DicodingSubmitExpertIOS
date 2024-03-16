//
//  JsonDecoderUtils.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

func decodeJSON<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
  let jsonDecoder = JSONDecoder()
  guard let result = try? jsonDecoder.decode(type, from: data) as T else { return nil }
  return result
}
