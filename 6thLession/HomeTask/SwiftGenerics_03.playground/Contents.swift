import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true
//Task 3. Linked list based on Enum *
enum LinkedList<T>{
    case None
    indirect case LinkedElement(value: T, next: LinkedList<T>)
    
    init() {
        self = .None
    }
}






