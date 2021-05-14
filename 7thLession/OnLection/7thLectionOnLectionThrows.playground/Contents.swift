import UIKit
//MARK: LESSION 7

struct CalculationError: Error {
    var localizedDescription: String?
}

func saveMoneyForItem(itemPrice: Double, salary: Double) throws -> Double {
    if salary <= 0 {
        let error = CalculationError(localizedDescription: "find a job")
        throw error
    }
    return itemPrice / salary
}

//let bitcoin = try saveMoneyForItem(itemPrice: 6800, salary: 0)

do {
    let bitcoin = try saveMoneyForItem(itemPrice: 6800, salary: 0)
} catch is CalculationError {
    print("calculation error")
} catch {
    print("general error")
}


