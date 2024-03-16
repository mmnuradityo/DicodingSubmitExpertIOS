//
//  InjectionTest.swift
//  DS_ExpertIOSTests
//
//  Created by Admin on 15/03/24.
//

import Cleanse
import XCTest

@testable import DS_ExpertIOS
final class InjectionTest: XCTestCase {
  
  func testExample() throws {
    let component = try? ComponentFactory.of(InjectionComponent.self)
    
    if let inject = component?.build(()) {
      
      let repository = inject.repository.get() as! GameRepository
      let anotherRepository = inject.repository.get() as! GameRepository
      
      let address = MemoryAddress(of: repository)
      let anotherAddress = MemoryAddress(of: anotherRepository)
      
      XCTAssertEqual(address.intValue, anotherAddress.intValue)
      
    } else {
      XCTAssertThrowsError(InjectError.notFound)
    }
  }
  
}

enum InjectError: Error {
  case notFound
}
