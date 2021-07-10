//
//  SwiftStaticLibrary.swift
//  SwiftStaticLibrary
//
//  Created by Иван Казанцев on 09.07.2021.
//
import Foundation
import AnotherSwiftStaticLibrary

open class SwiftStaticLibrary {

    public func sum(a: Int, b: Int) -> Int {
        return a + b
    }
    
    public func createAnotherLibrary() -> AnotherSwiftStaticLibrary {
        return AnotherSwiftStaticLibrary()
    }
    
    public init() {}

    
}
