import UIKit

// ! (don's)
var x: Int? = 8
x!
type(of: x)

// check first
if x != nil {
    x!
    x = x! + 1
}

type(of: x)

// optional binding (do's)
if let myNumber = x {
    myNumber + 1
    type(of: myNumber)
}

var y: Int!
type(of: y)

var highScore: Int
var loadedScore: Int?

if loadedScore != nil {
    highScore = loadedScore!
} else {
    highScore = 0
}

highScore = loadedScore != nil ? loadedScore! : 0

func checkPrime(num inputNumber: Int) -> String {
    var isPrime: Bool? = true

    if inputNumber <= 0 {
        isPrime = nil
    } else if inputNumber == 1 {
        isPrime = false
    } else {
        for i in 2 ..< inputNumber {
            if inputNumber % i == 0 {
                isPrime = false
            }
        }
    }

    if isPrime == true {
        return "\(inputNumber) is prime"
    } else if isPrime == false {
        return "\(inputNumber) is not prime"
    } else {
        return "please enter a Number > 0"
    }
}

func checkPrime(num inputNumber: Int, completedHandler handler: (String) -> Void) {
    handler(checkPrime(num: inputNumber))
}

checkPrime(num: 0, completedHandler: {
    (result: String) in
    print("\(result)")
})
