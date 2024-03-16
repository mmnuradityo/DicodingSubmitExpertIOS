//
//  MemoryAddress.swift
//  DS_ExpertIOSTests
//
//  Created by Admin on 15/03/24.
//

import Foundation

struct MemoryAddress<T>: CustomStringConvertible {
  
  let intValue: Int
  
  var description: String {
    let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
    return String(format: "%0\(length)p", intValue)
  }
  
  init(of structPointer: UnsafePointer<T>) {
    intValue = Int(bitPattern: structPointer)
  }
}

extension MemoryAddress where T: AnyObject {
  init(of classInstance: T) {
    intValue = unsafeBitCast(classInstance, to: Int.self)
  }
}
