import UIKit
//MARK: LESSION 8
//compactMap(_:) автоматически удаляет нил элементы из массива.
//complexity: O(m+n)
let possibleNumbers = ["1", "2", "three", "///4///", "5"]
let mapped = possibleNumbers.map { Int($0) }
print(mapped)
let compactMapped: [Int] = possibleNumbers.compactMap { Int($0) }
print(compactMapped)

let mapped2 = possibleNumbers.map { $0.uppercased() }
print(mapped2)
let compactMapped2 = possibleNumbers.compactMap { $0.uppercased() }
print(compactMapped2)
