import UIKit
//MARK: Реализовать COW в своей структуре со свойством reference type (isKnownUniquelyReferences)
enum Transmissions {
    case mechanic
    case automatic
    case robot
}

//MARK: Reference type // Class
final class Transmission {
    var value: Transmissions
    
    init(_ x: Transmissions) {
        value = x
    }
}
//MARK: Value type with Reference type propery // Struct
struct SportCar {
    private var transmission: Transmission //ref
    var horsePower: Int //value
    init(_ x: Transmissions, hP: Int) {
        transmission = Transmission(x)
        horsePower = hP
    }
    
    var tType: Transmissions {
        get { return transmission.value }
        set {
            if (!isKnownUniquelyReferenced(&transmission)) {
                transmission = Transmission(newValue)
                return
            }
            transmission.value = newValue
        }
    }
}
//creating instances
var honda = SportCar(.automatic, hP: 560)
var toyota = honda //this way we get copy
print(honda) //
print(toyota) //prints the same instance. reference type properties have references to same place in heap
toyota.tType = .robot
print(honda)
print(toyota)
honda.tType
toyota.tType

//MARK: Реализовать свой собственный Optional для Int

postfix operator <>!
postfix operator <>?
postfix func <>? (value: Int) -> OptInt<Int> {
    return OptInt(value)
}
postfix func <>! <Int>(value: OptInt<Int>) -> Any {
    return value.unwrap()
}

enum OptInt<Int> {
    
    case notValue
    case someValue(Int)
    
    init(_ someValue: Int) {
        self = .someValue(someValue)
    }
    
    init() {
        self = .notValue
    }
    
    func unwrap() -> Any {
        switch self {
        case .someValue(let x):
            return x
        default:
            fatalError("Unexpectedly found nil while unwrapping an OptInt value")
        }
    }
    
}

var firstValueWrapped = OptInt(5)
var secondValueWrapped = 10<>?
var firstValue = firstValueWrapped.unwrap()
var secondValue = secondValueWrapped<>!

