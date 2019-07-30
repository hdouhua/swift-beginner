

let helloClosure = {
    print("hello everybody")
}

helloClosure()

let eatClosure = {
    (foodName: String) in
    print("food name \(foodName)")
}

eatClosure("rice")

// 1,
// let addClosure = {
//    (num1: Int, num2: Int) -> Int in
//    return num1 + num2
// }
// 2,
// let addClosure:(Int, Int)->Int = {
//    (num1: Int, num2: Int) -> Int in
//    return num1 + num2
// }
// 3,
// let addClosure:(Int, Int)->Int = {
//    (num1, num2) in
//    return num1 + num2
// }
// 4,
// let addClosure:(Int, Int)->Int = {
//    (num1, num2) in num1 + num2
// }
// 5,
let addClosure: (Int, Int) -> Int = { $0 + $1 }
addClosure(1, 2)

let multiply = {
    (num1: Int, num2: Int) -> String in
    "\(num1) * \(num2) = \(num1 * num2)"
}

multiply(1, 2)

func calculate(num1: Int, num2: Int, operate: (Int, Int) -> Int) {
    print(operate(num1, num2))
}

calculate(num1: 3, num2: 8, operate: addClosure)

func giveMeMultiply() -> (Int, Int) -> String {
    return multiply
}

let doMultiply = giveMeMultiply()
doMultiply(1, 3)

var numArray = [1, 2, 3, 4, 5, 6, 7, 8]
numArray.map { (number: Int) -> Void in
    print(number)
}

// closure 多种写法
numArray.map { (number: Int) -> String in
    "this is a number \(number)"
}

numArray.map { "this is a number \($0)" }
numArray.map { "this is a number \($0)" }
// 仅一个参数，可以省略()
numArray.map { "this is a number \($0)" }

numArray.filter { (number: Int) -> Bool in
    number % 2 == 0
}

let x = numArray.filter { $0 % 2 == 0 }
x
numArray.filter { $0 > 5 }
