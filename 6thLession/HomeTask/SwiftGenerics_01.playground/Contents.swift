import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true
//Home task 1. Realize func sum on all data types
protocol SumProtocol {
    static func +(lhs: Self, rhs: Self) -> Self
}

extension Int: SumProtocol {}
extension Double: SumProtocol {}
extension String: SumProtocol {}
extension Float: SumProtocol {}

func sum<T: SumProtocol>(_ a: T, _ b: T) -> T {
    return a + b
}

sum(4, 8)
sum("abc", "abc")
