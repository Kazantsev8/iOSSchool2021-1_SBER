import UIKit
//MARK: LESSION 7
//MARK: РЕАЛИЗОВАТЬ ПРОВЕРЯЛЬЩИК ПРИМЕРОВ

//Реализуйте проверяльщик примеров.
//1. Есть массив строк. Но это не обычные строки - это примеры.
//Пример - это строка формата «32 + 16 = 48». В нём два числа слева от равно, одно число справа. Операции: сложение и вычитание.
//2. Есть функция checkHomework, которая:
//    1. Принимает массив примеров
//    2. И возвращает:
//        1. Если больше 75% ошибок в примерах - функция возвращает список всех примеров с ошибками и подписью «делай заново»
//        2. Если пример решён верно - возвращает строку «молодец»
//        3. Если нет примеров - возвращает строку «нет примеров»
//    3. Если ей на вход дать хотя бы один невалидный пример - выводит "переделывай" и не оценивает другие примеры
//3. Есть функция checkTask:
//    1. Она принимает пример
//    2. Если это не пример - надо кинуть исключение
//    3. Если пример решён правильно - возвращаем строку с похвалой. Если нет - возвращаем ошибку с правильным ответом
//Залейте код в приватный репозиторий на гитхабе, дайте доступ на leosilver@yandex.ru и скиньте ссылку в тред.

struct Failure: Error {
    var description: String
    var rightAnswer: String?
    var errorCode: Int?
    let errorCodes: [Int] = [1,2,3,4,5]
}

enum HomeworkResult<Value, Failure> {
    case success(checkedArray: [Value])
    case failure(message: Failure)
}

enum ExampleResult<Value, Failure> {
    case exampleCorrect(cheers: Value)
    case exampleIncorrect(error: Failure)
}

typealias EResult = ExampleResult<String, Failure>
typealias HWResult = HomeworkResult<String, Failure>

func checkTask(example: String) throws -> EResult {
    let splittedString = example.split(separator: " ")
    
    if splittedString.count != 5 {
        let error = Failure(description: "Parsing Error", errorCode: 1)
        throw error
    }
    
    let operation = splittedString[1]
    
    guard let operand1 = Int(splittedString[0]) else {
        let error = Failure(description: "Operand 1 is nan", errorCode: 2)
        throw error
    }
    guard var operand2 = Int(splittedString[2]) else {
        let error = Failure(description: "Operand 2 is nan", errorCode: 3)
        throw error
    }
    guard let result = Int(splittedString[4]) else {
        let error = Failure(description: "Result is nan", errorCode: 4)
        throw error
    }
    if splittedString[3] != "=" {
        let error = Failure(description: "Not an equation", errorCode: 5)
        throw error
    }
    
    if operation == "-" {
        operand2 = -operand2
    }
    
    if operand1 + operand2 != result {
        let rightAnswer = String(operand1 + operand2)
        let wrongAnswer = Failure(description: "Wrong answer", rightAnswer: rightAnswer)
        return .exampleIncorrect(error: wrongAnswer)
    } else {
        return .exampleCorrect(cheers: "Good Job!")
    }
}

func checkHomework(homeWork: [String]) -> HWResult {
    var homeWorkState: [String] = []
    var wrongAnswers: [String] = []
    var correctAnswers: [String] = []
    if homeWork.isEmpty {
        let message = Failure(description: "Your homework is empty!")
        print(message)
        return .failure(message: message)
    }
    
    for each in homeWork {
        do {
            let homeWork = try checkTask(example: each)
            switch homeWork {
            case .exampleCorrect(let cheers):
                homeWorkState.append(cheers)
                correctAnswers.append(each)
            case .exampleIncorrect(let error):
                guard let answer = error.rightAnswer else {
                    return .failure(message: .init(description: "can not calculate right answer"))
                }
                homeWorkState.append("Not correct solution. Right solution is: \(answer)")
                wrongAnswers.append("\(each). Do it again")
            }
        } catch let error as Failure {
            if error.errorCodes.contains(error.errorCode!) {
                let message = Failure(description: "Error #\(error.errorCode!). \(error.description)")
                print(message.description)
                return .failure(message: message)
            }
        } catch {
            print("default error")
        }
    }

    if Double(wrongAnswers.count)/Double(homeWorkState.count) >= 0.75 {
        return .success(checkedArray: wrongAnswers)
    }
    
    return .success(checkedArray: homeWorkState)
}

let homeWork = ["25 + 45 = 34","25 + 25 = 50","23 - 0 = 34","25 + 43 = 0"]
let goodHomeWork = ["25 + 45 = 70","25 + 25 = 50","23 - 0 = 23","25 + 43 = 68"]
let normalHomeWork = ["25 + 45 = 70","25 + 25 = 0","23 - 0 = 23","25 + 43 = 0"]
let emptyHomeWork: [String] = []
checkHomework(homeWork: homeWork)
checkHomework(homeWork: goodHomeWork)
checkHomework(homeWork: normalHomeWork)
checkHomework(homeWork: emptyHomeWork)


