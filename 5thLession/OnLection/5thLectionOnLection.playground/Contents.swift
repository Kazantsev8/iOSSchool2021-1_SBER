import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true
//STRING
//var string = "My name is Alex and this is my string"
//
//let distance = string.distance(from: string.firstIndex(of: "y") ?? string.startIndex, to: string.endIndex)
////PROTOCOLS
//
//
//protocol TextRepresentable {
//    var textDescription: String { get }
//}
//
////extension TextRepresentable {
////    var textDescription: String {
////        // "My name is \(name) and age is \(age)"
////    }
////}
//
//struct Human1 {
//    var name: String
//    var age: Int
//}
//
//extension Human1: TextRepresentable {
//
//}
//
//let human = Human1(name: "Igor", age: 25)
//
//extension Array: TextRepresentable where Element == Human1 {
//
//    var textDescription: String {
//        let summ = reduce(0) { $0 + Int($1.age) }
//    return "Sum age is \(summ)"
//    }
//}

//DISPATCH

protocol Sayable {
    //func say()
}

extension Sayable {
    func say() {
        print("Sayable.say()")
    }
}

class Human: Sayable {
    func say() {
        print("Human.say()")
    }
}

class Animal {
    
}

extension Animal: Sayable {
    func say() {
        print("Animal.say()")
    }
}

let human: Sayable = Human()
let animal: Sayable = Animal()


human.say()
animal.say()
