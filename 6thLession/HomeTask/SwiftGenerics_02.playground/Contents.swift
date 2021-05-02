import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true
//Task 2. Realize Linked List and Queue with generics.
//Element for Linked List with T placeholder
public class LinkedElement<T> {
    
    var value: T
    var next: LinkedElement?
    weak var previous: LinkedElement?
    
    init (value: T) {
        self.value = value
    }
    
}

//Linked List realization
public class LinkedList<T> {
    
    public typealias Element = T
    
    private var head: LinkedElement<Element>?
    private var tail: LinkedElement<Element>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    public var first: LinkedElement<Element>? {
        print(head?.value ?? "no head value")
        return head
    }
    public var last: LinkedElement<Element>? {
        print(tail?.value ?? "no tail value")
        return tail
    }
    
    public func append(element: Element) {
        let newElement = LinkedElement<Element>(value: element)
        
        if let tailElement = tail {
            newElement.previous = tailElement
            tailElement.next = newElement
        } else {
            head = newElement
        }
        tail = newElement
    }
    
    public func pushElementAt(index: Int) -> LinkedElement<T>? {
        if index >= 0 {
            var element = head
            var i = index
            while element != nil {
                if i == 0 { return element }
                i -= 1
                element = element!.next
            }
        }
        return nil
    }
    
    public func removeAllElements() {
        head = nil
        tail = nil
    }
    
    public func remove(element: LinkedElement<T>) {
        let previous = element.previous
        let next = element.next
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        next?.previous = previous
        if next == nil {
            tail = previous
        }
        element.previous = nil
        element.next = nil
        print("\(element.value) removed")
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var element = head
        while element != nil {
            text += "\(element!.value)"
            element = element!.next
            if element != nil {
                text += ", "
            }
        }
        return text + "]"
    }
}

let myLinkedList = LinkedList<String>()
myLinkedList.append(element: "First")
myLinkedList.append(element: "Second")
myLinkedList.append(element: "Third")
print(myLinkedList)

//Queue realization on previous Linked List
public struct Queue<T> {
    
    private var list = LinkedList<T>()
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        list.append(element: element)
    }
    
    public mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }
        list.remove(element: element)
        return element.value
    }
    
    public func peek() -> T? {
        return list.first?.value
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}

var myQueue = Queue<String>()
myQueue.enqueue("This")
myQueue.enqueue("is")
myQueue.enqueue("my")
myQueue.enqueue("queue")
print(myQueue.description)
myQueue.dequeue()
print(myQueue.description)


