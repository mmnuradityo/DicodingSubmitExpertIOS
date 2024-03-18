//
//  RouterTests.swift
//  DS_ExpertIOSTests
//
//  Created by Admin on 18/03/24.
//

import XCTest
import RealmSwift
@testable import DS_ExpertIOS

final class RouterTests: XCTestCase {
  
  func testHomeRouter() throws {
    let homeRouter = HomeRouter().makeDetailView(game: nil)
    XCTAssertNotNil(homeRouter)
  }
  
  func testFavoriteRouter() throws {
    let favoriteRouter = FavoriteRouter().makeDetailView(game: nil)
    XCTAssertNotNil(favoriteRouter)
  }
  
  public func testMakeSearchViewBar() throws {
    let searchBar = MainRouter().makeSearchViewBar()
    XCTAssertNotNil(searchBar)
  }
  
  public func testMakeHomeViewController() throws {
    let homeVc = MainRouter().makeHomeViewController()
    XCTAssertNotNil(homeVc)
  }
  
  public func testMakeFavoriteViewController() throws {
    let favoriteVc = MainRouter().makeFavoriteViewController()
    XCTAssertNotNil(favoriteVc)
  }
  
  public func testMakeProfileViewController() throws {
    let profileVc = MainRouter().makeProfileViewController()
    XCTAssertNotNil(profileVc)
  }
  
}
