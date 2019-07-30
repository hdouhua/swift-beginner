import UIKit

var price = 80

if price > 150 {
    print("are you crazy?")
} else if price < 50 {
    print("very cheap")
} else {
    print("buy it")
}

let myName = "dao"
if myName == "dao" {
    print("hello")
} else {
    print("who are you")
}

if myName != "dao" {
    print("who are you")
} else {
    print("hello")
}

price = 200
switch price {
case 100 ..< 200:
    print("just so so")
case 200 ... 400:
    print("too expensive")
default:
    print("buy it")
}

var animal = ["dog", "cat", "sheep", "monkey", "douhua"]
for an in animal {
    print(an)
}

var lowercases = [String]()
type(of: lowercases)

var fruitDict = ["red": "apple", "green": "watermelon", "yellow": "banana"]
for (key, value) in fruitDict {
    print("\(key) = \(value)")
}

let colors = ("red", "blue", "green", "yellow")
colors.0
colors.1

let tuple1 = (3.14, ["apple", "watermelon"], true)
tuple1
tuple1.1[0]

let tuple2 = (red: "apple", green: "watermelon", yellow: "banana")
tuple2.red
tuple2.yellow

var index = 0
while index < 10 {
    index * index
    index += 1
}

repeat {
    index * index
    index -= 1
} while index > 0
