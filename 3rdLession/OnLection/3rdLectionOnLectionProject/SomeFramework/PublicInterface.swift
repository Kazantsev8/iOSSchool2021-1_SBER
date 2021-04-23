//
//  PublicInterface.swift
//  SomeFramework
//
//  Created by Иван Казанцев on 23.04.2021.
//

import Foundation

open class SomeFrameworkBaseClass {
    
    public init() {}
    
    public func doSomething() {
        print("do something")
    }
    
}

public class SomeClassChild: SomeFrameworkBaseClass {
    
    public override func doSomething() {
        print("do something another")
    }
    
}
