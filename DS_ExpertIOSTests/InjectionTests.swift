//
//  InjectionTests.swift
//  InjectionTests
//
//  Created by Admin on 18/03/24.
//

import XCTest
import RealmSwift

@testable import DS_ExpertIOS
final class InjectionTests: XCTestCase {
  
  func testHomeUseCase() throws {
    let homeUseCase = Injection().provideHomeUseCase()
    XCTAssertNotNil(homeUseCase)
  }
  
  func testFavoriteUseCase() throws {
    let favoriteUseCase = Injection().provideFavoriteUseCase()
    XCTAssertNotNil(favoriteUseCase)
  }
  
}
