import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: METHOD DISPATCH
//===============================================================
//MARK: DIRECT(STATIC) DISPATCH
//+ БЫСТРЫЙ В ВЫПОЛНЕНИИ
//- НЕТ ПОЛИМОРФИЗМА, НЕТ НАСЛЕДОВАНИЯ
//---------------------------------------------------------------
//так как функция в extension, то static dispatch
protocol DirectDProtocol1 {
    func doSomething()
}

extension DirectDProtocol1 {
    func doSomething() {
        print("Hello")
    }
}
//---------------------------------------------------------------
//так как функция в extension, то static dispatch
class DirectDClass1 {
    
}
extension DirectDClass1 {
    func doSomething() {
        print("Hello")
    }
}
//---------------------------------------------------------------
//не можем оверрайдить, не поддерживает наследование, следовательное тоже static dispatch
//все обращения и функции этого класса становятся static
final class DirectDClass2 {
    func doSomething() {
        print("Hello")
    }
}
//===============================================================
//MARK: WITNESS TABLE(DYNAMIC) DISPATCH
//- МЕДЛЕННЕЕ STATIC'А
//+ ЕСТЬ ПОЛИМОРФИЗМ (можно по разному реализовывать протоколы)
//- НЕТ НАСЛЕДОВАНИЯ
//---------------------------------------------------------------
//создается таблица в памяти, в которой ссылка на протокол и на метод
//когда будем вызывать метод у класса, компилятор обратится к witness table и с помощью него найдет метод, который мы хотим вызвать
//для каждого класса и протокола - своя таблица
protocol WitnessTableDProtocol1 {
    func doSomething()
}
class WitnessTableDClass1: WitnessTableDProtocol1 {
    func doSomething() {
        print("Hello")
    }
}
//===============================================================
//MARK: VIRTUAL TABLE(DYNAMIC) DISPATCH
//+ скорость как у Witness Table Dispatch
//+ есть полиморфизм, есть наследование
//- затраты на компиляцию
//---------------------------------------------------------------
//для каждого наследования класса создается своя виртуальная таблица. Ищет метод от верхнего уровня к нижнему.
class VirtualTableDClass1 {
    func doSomething() { }
}
class VirtualTableDClass2: VirtualTableDClass1 {
    override func doSomething() {
        print("Hello")
    }
    func doSomething2() {
        print("Hello")
    }
}
//===============================================================
//MARK: MESSAGE DISPATCH (obj-c)
//+ KVC/KVO
//+ Method Swizzling
//- самый медленный
//на нем работает obj-c runtime, мы пытаемся найти метод в таблице, с помощью его посланных сообщений
//SWIZZLING: отличие от остальных диспетчеризаций в том, что проставление всех ссылок на методы происходит в runtime, поэтому мы можем подменять реализацию и экземпляры классов на ходу в runtime (применяется редко и так делать не хорошо)
//Message dispatch позволяет использовать Key Value Coding, Key Value Observing (NSObject наследник)
//если проставляем @objc у метода, то это значит, что метод становится виден для obj-c runtime, а если добавляем dynamic, то это значит, что метод будет работать с message dispatch.
//---------------------------------------------------------------
@objcMembers
class MessageDClass1: NSObject {
    //когда используем dynamic для NSObject - мы говорим, что метод не только виден для obj-c runtime, но и работает через message dispatch
    dynamic func doSomething() {
        print("Hello")
    }
}
@objcMembers
class MessageDClass2: MessageDClass1 {
    override dynamic func doSomething() {
        print("Hello1")
    }
}
//в данном случае у нас есть super, т.к все эти классы - наследники NSObject, в runtime проставляются ссылки на все эти методы. Когда мы начниаем вызывать метод, то objc runtime пытается найти метод в нашем классе, потом переходит к родительскому классу и ищет там. Если в родительском классе он метод не нашел, то переходит к NSObject. Если в NSObject он метод не находит, то включается Message Forwarding. У объектов NSObject имеют метод perform(), который позволяет вызвать метод просто по его названию. Так же есть метод canPerformAction(), который позволяет проверить, содержится ли метод в классе.
//===============================================================
//MARK: БАГИ SWIFT
//---------------------------------------------------------------
//MARK: 1
//данный баг решается обявлением метода в теле протокола
protocol SwiftBugProtocol1 {
    //func saySomething()
}
extension SwiftBugProtocol1 {
    func saySomething() {
        print("Hello from protocol")
    }
}
class SwiftBugClass1: SwiftBugProtocol1 {
    func saySomething() {
        print("Hello from class")
    }
}

let myClassInstance = SwiftBugClass1() //Witness table dispatch
let myClassInstance1: SwiftBugProtocol1 = SwiftBugClass1() //Static dispatch

myClassInstance.saySomething()
myClassInstance1.saySomething() //вызовется метод из протокола, потому что он будет работать через static dispatch
//---------------------------------------------------------------
//MARK: 2
//решается тем, что Root Class должен иметь объявление метода
protocol SwiftBugProtocol2 {
    func saySomething()
}
extension SwiftBugProtocol2 {
    func saySomething() {
        print("Hello from protocol")
    }
}
//root class
class SwiftBugClass2: SwiftBugProtocol2 {
    //func saySomething() { }
}

class SwiftBugClass3: SwiftBugClass2 {
    //override
    func saySomething() {
        print("Hello from class")
    }
}

let myClassInstance2 = SwiftBugClass3()
let myClassInstance3: SwiftBugClass2 = SwiftBugClass3()

myClassInstance2.saySomething()
myClassInstance3.saySomething() //баг свифта, если добавить в Root Class этот метод, то он будет вызываться уже через Virtual Table
//===============================================================
//MARK: ПРИМЕР SWIZZLING

class SwizzlingClass {
    //делаем метод видимым для obj-c runtime
    @objc dynamic class func saveSomeThings(_ someThings: [String]) {
        print("code is called")
    }
}

class TestClass {
    @objc dynamic class func testSaveSomeThings(_ someThings: [String]) {
        print("testing code is called")
    }
    //перехватываем вызов оригинального метода
    static let originalMethod = class_getClassMethod(SwizzlingClass.self,
                                                     #selector(SwizzlingClass.saveSomeThings(_:))) //перехват метода в экземпляр класса
    //говорим, что будем свиззлить этот метод
    static let swizzledMethod = class_getClassMethod(TestClass.self,
                                                     #selector(TestClass.testSaveSomeThings(_:)))
    static func someTestMethod() {
        method_exchangeImplementations(originalMethod!, swizzledMethod!) //меняем наши реализации местами
    }
    static func stop() {
        method_exchangeImplementations(originalMethod!, swizzledMethod!) //меняем обратно методы местами
    }
}
