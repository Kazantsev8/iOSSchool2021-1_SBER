import UIKit
//MARK: LESSION 7

struct CalculationError: Error {
    var localizedDescription: String?
}

func saveMoneyForItem(itemPrice: Double, salary: Double) -> Result<Double, CalculationError> {
    if salary == 0 {
        let error = CalculationError(localizedDescription: "Get a job!")
        return .failure(error)
    }
    return .success(itemPrice / salary)
}

let bitcoin = saveMoneyForItem(itemPrice: 2600, salary: 0)

switch bitcoin {
case .success(let months):
    print(months)
case .failure(let error):
    print(error.localizedDescription)
}

enum CalculationResult<Value, FailureValue>{
    case success (numberOfMonths: Double)
    case error (error: CalculationError)
    case warning (numberOfMoths: Double, message: String)

}

func saveMoneyForItem1(itemPrice: Double, salary: Double) -> CalculationResult<Double, CalculationError> {
    if salary <= 0 {
        let error = CalculationError(localizedDescription: "find a job!")
        return .error(error: error)
    }
    let time = itemPrice / salary
    if time > 12 {
        return .warning(numberOfMoths: time, message: "no worth to spend")
    }
    return .success(numberOfMonths: time)
}



