import UIKit
//MARK: ПАТТЕРН ОДИНОЧКА
//Это порождающий паттерн, который гарантирует существование только одного объекта определенного класса, а также позволяет достучаться до этого объекта из любого места программы

class SomeClass {
    static var shared: SomeClass = {
        let instance = SomeClass()
        return instance
    }()
    
    private init() {}
    
    func someFunc() {
        
    }
}

SomeClass.shared.someFunc()

