//
//  AnotherSwiftStaticLibrary.swift
//  AnotherSwiftStaticLibrary
//
//  Created by Иван Казанцев on 09.07.2021.
//
import Foundation

///
@objc open class AnotherSwiftStaticLibrary: NSObject {

    public func sum(a: Int, b: Int) -> Int {
        return a + b
    }
    
    public override init() {}
    
}
