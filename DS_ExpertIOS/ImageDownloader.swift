//
//  File.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation
import Combine
import Alamofire

protocol ImageDownloaderProtocol {
  func downloadImage(url: URL) -> AnyPublisher<Data?, Never>
}

class ImageDownloader: ImageDownloaderProtocol {
  
  func downloadImage(url: URL) -> AnyPublisher<Data?, Never> {
    return Future { completion in
      AF.request(url)
        .validate()
        .response { data in
          completion(.success(data.data))
        }
    }.eraseToAnyPublisher()
  }
  
}
