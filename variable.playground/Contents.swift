import UIKit

var str = "Hello, playground"

var ratingList = ["poor", "fine", "good", "excellent"]
ratingList[0] = "ok"
ratingList

var implictlyUnwrappedOptionalInt: Int!
implictlyUnwrappedOptionalInt = 1

let x = implictlyUnwrappedOptionalInt?.advanced(by: 1)
x

var optionalHello: String? = "Hello"
var greeting: String
let optionalName: String? = "dao"
if let hello = optionalHello, hello.hasPrefix("H"), let name = optionalName {
    greeting = "\(hello), \(name)"
}

let vegetable = "red pepper"
var vegetableComment: String
switch vegetable {
case "celery":
    vegetableComment = "add some raisins and make ants on a log"
case "cucumber", "watercress":
    vegetableComment = "that would make a good tea sandwich"
case let x where x.hasSuffix("pepper"):
    vegetableComment = "is it a spicy \(x)?"
default:
    vegetableComment = "no comment"
}
vegetableComment

var secondForLoop = 0
for _ in 0 ... 4 {
    secondForLoop += 1
}

secondForLoop

func greet(_ name: String, _ day: String) -> String {
    return "Hello \(name), today is \(day)."
}

greet("dao", "20190725")
greet("dao", "today")

class NamedShape {
    var numberOfSides = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides)"
    }
}

NamedShape(name: "triangle")
