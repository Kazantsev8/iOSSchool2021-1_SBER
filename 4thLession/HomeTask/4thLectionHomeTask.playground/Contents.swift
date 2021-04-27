import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true

//HOMETASK
//MARK: ЗАДАНИЕ: Описать различие Objective-C Blocks and Swift Closures
/*MARK: Сходства:
 - функционально Objective-C Block и Swift Closure одинаковы. Но стоит отметить, что closure проще чем блок, и это позволяет нам избежать сложности управления им и памятью;
 - Objective-C Block и Swift Closure совместимы. Поэтому мы имеем возможность передавать методы Swift Closures в Objective-C Block;
 - Objective-C Block и Swift Closure имеют один и тот же тип;
 */
/*MARK: Различия:
 - Objective-C Blocks и Swift Closures имеют похожую семантику захвата, но у closures переменные изменяются, а у blocks копируются. То есть поведение с маркером _block в Objective-C является стандатным поведением в Swift Closures.
 */

//MARK: Дополнительною. HASHABLE в SWIFT
/*
 Протокол Hashable предоставляет нам результаты хеш-функции, то есть хэш значение экземпляра, который поддерживает этот протокол. Данный протокол является обязательным для работы с Dictionary и Set.
 Протокол Hashable содержит свойство:
    public var hashValue: Int { get } - данное свойство использует внутренний алгоритм, чтобы подсчитать хеш-значение для требуемого экземпляра.
 Если программа содержит слишком много экземпляров, то возможны так называемые хеш-коллизии, когда значения hashValue у экземпляров совпадут. Данная проблема достаточно известна и решаема, однако, идеальная хеш-функция должна выдавать уникальные значения.
 В стандартном наборе следующие типы соответствуют Hashable: String, Int, Float, Boolean и т.д. Так же кастомные типы могут поддерживать протокол Hashable. Однако, так как Hashable наследуется от прокотола Equatable, то кастомный тип должен так же удовлетворять требованиям протокола Equatable.
 Хеш-функция предоставлена типом Hasher. Для реализации необходимо вызвать метод combine(_:) для значений в теле функции hash(into:). На примере это выглядит следующим образом:
 */
struct CustomStruct {
    var x: Int
    var y: Int
}

extension CustomStruct: Hashable {
    static func == (lhs: CustomStruct, rhs: CustomStruct) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
//В данном примере hash(into:) подает свойства x и y в предоставленный хешер. Эти же свойства используются для проверки на равенство в функции ==.


var array = [1,2,3]
var set: Set = [1,2,3]
//Функция для замера времени выполнения кода с использованием completion (closure).
func timeMeasureRunningCode(title: String, completionHandler: () -> ()) {
    let start = CFAbsoluteTimeGetCurrent()
    completionHandler()
    let finish = CFAbsoluteTimeGetCurrent()
    let timeElapsed = finish - start
    print("Time for \(title) is \(timeElapsed) seconds.")
}


