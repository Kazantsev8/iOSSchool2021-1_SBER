import UIKit
//MARK: First Exercise
@propertyWrapper
struct StringConcat {
    private var name: String = ""
    public var wrappedValue: String {
        get {
            return name
        }
        set {
            if name.isEmpty{
                name += newValue
            } else {
            name += " " + newValue
            }
        }
    }
}

struct MyStruct {
    @StringConcat var name: String
}

var example = MyStruct()
example.name = "Alex"
example.name = "Moran"

print(example.name)
//MARK: First Exercise
//MARK: Second Exercise
protocol AnimalAgeConvertable {
    
    func convertToHumanAge() -> Int
    
}

extension AnimalAgeConvertable {
    //default implementation
    func humanAge() -> Int {
        return 0
    }
    
}

struct Cat {
    let age: Int
    let name: String
}

struct Dog: AnimalAgeConvertable {
    func convertToHumanAge() -> Int { age * 5 }
    
    let age: Int
    let name: String
    
}

extension Cat: AnimalAgeConvertable {
    
    func convertToHumanAge() -> Int { age * 2 }
    
}

let cat = Cat(age: 15, name: "Garfield")
let dog = Dog(age: 5, name: "Bobik")

func printAnimalAge(animalAgeConvertable: AnimalAgeConvertable) {
    print("Animal age is: \(animalAgeConvertable.convertToHumanAge())")
}

printAnimalAge(animalAgeConvertable: cat)
printAnimalAge(animalAgeConvertable: dog)
//MARK: Second Exercise
//MARK: Third Exercise
enum SomeEnum {
    case one
    case two
    case three(Int)
    
    var debugMessage: String {
        switch self {
        case .one: return "someEnum.one"
        case .two: return "someEnum.two"
        case .three(let value): return "someEnum.three(\(value))"
        }
    }
    
}

print(SomeEnum.three(5).debugMessage)
//MARK: Third Exercise


