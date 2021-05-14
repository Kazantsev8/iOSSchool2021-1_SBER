import UIKit
//MARK: ПАТТЕРН АДАПТЕР
//Это структурный паттерн, позволяющий подружить несовместимые объекты

//Целевой класс объявляет интерфейс, с которым может работать клиентский код
class JSONClass {
    func request() -> String {
        return "Right format"
    }
}
//С этим классом клиентский код работать не может
class XMLAdaptee {
    public func specificRequest() -> String {
        return "Not right format"
    }
    
    init() {}
}
//Класс адаптер, в котором мы переопределяем request для неподходящего класса (адаптируем)
class XMLAdapter: JSONClass {
    private var adaptee: XMLAdaptee
    
    init(_ adaptee: XMLAdaptee) {
        self.adaptee = adaptee
    }
    
    override func request() -> String {
        return adaptee.specificRequest() + " (converted to right format)."
    }
}
//Теперь мы можем работать с адаптированным форматом
class Customer {
    static func someCode(target: JSONClass) {
        print(target.request())
    }
}

var defaultFormat = JSONClass()
var adaptee = XMLAdaptee()
var adapter = XMLAdapter(adaptee)
Customer.someCode(target: adapter)
Customer.someCode(target: defaultFormat)
