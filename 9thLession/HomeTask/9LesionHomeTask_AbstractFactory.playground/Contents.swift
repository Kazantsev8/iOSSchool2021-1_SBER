import Foundation
import XCTest
//MARK: Паттерн Абстрактная Фабрика.
//Это порождающий паттерн проектирования, которые позволяет создавать семейства связанных объектов, не привязываясь к конкретным классам создаваемых объектов.
//Пример использования данного паттерна на создании симулятора мебельного магазина.

enum Style: String {
    case classic = "Classic"
    case modern = "Modern"
}

enum Color: String {
    case white = "White"
    case gold = "Gold"
}

struct Failure: Error {
    var description: String
}

//MARK: PROTOCOLS
protocol FurnitureProtocol {
    var style: Style { get }
    var color: Color { get }
    var name: String { get }
}

protocol ChairProtocol: FurnitureProtocol {
    var isThereABack: Bool { get }
}

protocol TableProtocol: FurnitureProtocol {
    var isUnpackable: Bool { get }
}

protocol SofaProtocol: FurnitureProtocol {
    var places: Int { get }
}

//MARK: CLASSIC GOLD FURNITURE
class ClassicGoldChair: ChairProtocol {
    var name: String = "Classic Gold Chair"
    var isThereABack: Bool = true
    var style: Style = .classic
    var color: Color = .gold
}
class ClassicGoldSofa: SofaProtocol {
    var places: Int = 3
    var style: Style = .classic
    var color: Color = .gold
    var name: String = "Classic Gold Sofa"
}
class ClassicGoldTable: TableProtocol {
    var isUnpackable: Bool = true
    var style: Style = .classic
    var color: Color = .gold
    var name: String = "Classic Gold Table"
}

//MARK: MODERN WHITE FURNITURE
class ModernWhiteChair: ChairProtocol {
    var isThereABack: Bool = true
    var style: Style = .modern
    var color: Color = .white
    var name: String = "Modern White Chair"
}
class ModernWhiteSofa: SofaProtocol {
    var places: Int = 3
    var style: Style = .modern
    var color: Color = .white
    var name: String = "Modern White Sofa"
}
class ModernWhiteTable: TableProtocol {
    var isUnpackable: Bool = true
    var style: Style = .modern
    var color: Color = .white
    var name: String = "Modern White Table"
}

//MARK: ABSTRACT FACTORY
protocol AbstractFactory {
    func createChair() -> ChairProtocol
    func createSofa() -> SofaProtocol
    func createTable() -> TableProtocol
}

//MARK: CLASSIC GOLD FURNITURE FACTORY
class ClassicGoldFurnitureFactory: AbstractFactory {
    func createChair() -> ChairProtocol {
        print("Classic Gold Chair Created")
        return ClassicGoldChair()
    }
    func createSofa() -> SofaProtocol {
        print("Classic Gold Sofa Created")
        return ClassicGoldSofa()
    }
    func createTable() -> TableProtocol {
        print("Classic Gold Table Created")
        return ClassicGoldTable()
    }
}

//MARK: MODERN WHITE FURNITURE FACTORY
class ModernWhiteFurnitureFactory: AbstractFactory {
    func createChair() -> ChairProtocol {
        print("Modern White Chair Created")
        return ModernWhiteChair()
    }
    func createSofa() -> SofaProtocol {
        print("Modern White Sofa Created")
        return ModernWhiteSofa()
    }
    func createTable() -> TableProtocol {
        print("Modern White Table Created")
        return ModernWhiteTable()
    }
}

//MARK: CUSTOMER
class Customer{
    init() {}
    func createFurniture (factory: AbstractFactory, style: String, color: String) throws -> (ChairProtocol, SofaProtocol, TableProtocol){
        if  (factory is ClassicGoldFurnitureFactory && (style != "Classic" || color != "Gold")) ||
            (factory is ModernWhiteFurnitureFactory && (style != "Modern" || color != "White")) {
            let error = Failure(description: "Wrong type of factory or parameters")
            throw error
        }
        switch (style, color) {
        case ("Classic", "Gold"):
            let chair = factory.createChair()
            let sofa = factory.createSofa()
            let table = factory.createTable()
            return (chair, sofa, table)
        case ("Modern", "White"):
            let chair = factory.createChair()
            let sofa = factory.createSofa()
            let table = factory.createTable()
            return (chair, sofa, table)
        default:
            let error = Failure(description: "This style and(or) color is not available")
            throw error
        }
    }
}

let customer = Customer()

do {
    let firstFurniture = try customer.createFurniture(factory: ClassicGoldFurnitureFactory(), style: "Classic", color: "Gold")
    let secondFurniture = try customer.createFurniture(factory: ModernWhiteFurnitureFactory(), style: "Modern", color: "White")
    let thirdFurniture = try customer.createFurniture(factory: ClassicGoldFurnitureFactory(), style: "Modern", color: "Green")
} catch let error as Failure {
    print("Error: \(error.description)")
}
