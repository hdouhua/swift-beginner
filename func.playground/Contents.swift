import UIKit

var str = "Hello, playground"
// 外部参数名 userName, 内部参数名 name
func sayHello(userName name: String) -> String {
    let message = "Hello " + name + "!"
    return message
}

// sayHello(name: "dao")
sayHello(userName: "dao")

func sayMessage(message: String) {
    print("say \(message)")
}

sayMessage(message: "hello dao")

func minmaxScores(scores: [Int]) -> (minScore: Int, maxScore: Int)? {
    if scores.isEmpty {
        return nil
    }
    var curMin = scores[0], curMax = scores[0]
    for n in scores[1 ..< scores.count] {
        curMin = min(curMin, n)
        curMax = max(curMax, n)
    }
    return (curMin, curMax)
}

var userScores: [Int]? = [12, 990, 13, 9990, 560]
userScores = userScores ?? []
if let result = minmaxScores(scores: userScores!) {
    print("min score \(result.minScore), max score \(result.maxScore)")
}

// closure
var arr: [Int] = [1, 3, 3, 5, 2, 9, 6, 7]
arr.sorted()

func compareTwoInts(a: Int, b: Int) -> Bool {
    return a > b
}

arr.sorted(by: compareTwoInts)
let arr1 = arr.sorted(by: { (a: Int, b: Int) -> Bool in a > b })
arr1
// simplify syntax
let arr2 = arr.sorted(by: { a, b in a > b })
arr2
let arr3 = arr.sorted(by: { a, b in a > b })
arr3
let arr4 = arr.sorted(by: { $0 > $1 })
arr4
let arr5 = arr.sorted(by: >)
arr5

var strArr = ["d", "a", "ab", "abc", "dwe", "wefwet", "bd"]
let sortedStrArr = strArr.sorted(by: { (str1: String, str2: String) -> Bool in
    if str1.count != str2.count {
        return str1.count < str2.count
    }
    return str1 < str2
})
sortedStrArr

// trailing closure
let sortedStr2 = strArr.sorted { (str1: String, str2: String) in

    if str1.count != str2.count {
        return str1.count < str2.count
    }
    return str1 < str2
}

sortedStr2

// capturing values
var offset5Arr: [Int] = arr.sorted {
    abs($0 - 5) < abs($1 - 5)
}

offset5Arr
var offset = 3
var offset5: [Int] = arr.sorted {
    abs($0 - offset) < abs($1 - offset)
}

// value type and reference type
func calcTotalMiles(todayMiles: Int) -> () -> Int {
    var totalMiles = 0

    return {
        totalMiles += todayMiles
        return totalMiles
    }
}

var dailyTwoMiles = calcTotalMiles(todayMiles: 2)
dailyTwoMiles()
dailyTwoMiles()

var myPlan = dailyTwoMiles
myPlan()
myPlan()
myPlan()

// enum
enum GameEnding {
    case Win
    case Lose
    case Draw
}

var yourScore = 80
var enemyScore = 100
var theGameEnding: GameEnding = GameEnding.Draw
if yourScore > enemyScore {
    theGameEnding = GameEnding.Win
} else if yourScore == enemyScore {
    theGameEnding = .Draw
} else {
    theGameEnding = .Lose
}

switch theGameEnding {
case .Win:
    print("you win")
case .Lose:
    print("you lose")
default:
    print("draw")
}

enum Month: Int {
    case Jan = 1, Fed, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
}

let curMonth: Month = .Jun
curMonth.rawValue
let nextMonth: Month? = Month(rawValue: 1)
nextMonth!

enum BarCode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

let productCodeA = BarCode.UPCA(4, 102, 345, 8)
let productcodeB = BarCode.QRCode("this is a information")

switch productCodeA {
case let BarCode.UPCA(numberSystem, manufacture, identifier, check):
    print("UPC-A with the value: \(numberSystem) \(manufacture) \(identifier) \(check)")
case let BarCode.QRCode(productCode):
    print("QRCode with the value: \(productCode)")
}

// set
var aa = Set<Int>()
aa.insert(1)
aa.insert(2)
aa.insert(3)
aa
var bb: Set<Int> = [1, 4, 3]
var cc = Set<Int>([1, 6, 5, 3])
aa.count
aa.isEmpty
for a in aa {
    a
}

aa.remove(1)
aa
bb.intersection(aa)
bb.isSubset(of: aa)
aa.isSubset(of: bb)
aa.remove(2)
aa.isSubset(of: bb)
bb.isSuperset(of: aa)
