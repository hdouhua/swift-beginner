import UIKit

class Lego {
    var color = "blue"
    var size = 8

    func connect() {
        print("connect with another block")
    }

    func remove() {
        print("disconnect with another block")
    }
}

var oneBlock = Lego()
oneBlock.color
oneBlock.size
oneBlock.connect()
oneBlock.remove()

class Baby {
    var name: String
    var age: Int

    init() {
        name = "Mike"
        age = 1
    }

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func sleep() {
        print("baby \(name) is sleeping...")
    }

    func introduce() {
        print("My name is \(name), I'm \(age) year(s) old")
    }
}

var tom = Baby(name: "Tom", age: 1)
tom.sleep()
tom.introduce()
var nancy = Baby(name: "Nancy", age: 3)
nancy.introduce()

class CuteBaby: Baby {
    var nickName: String

    override init() {
        nickName = "QQ"
        super.init()
        sleep()
    }

    override func sleep() {
        super.sleep()
        print("sleeping with cute smile")
    }
}

var iamsoQ = CuteBaby()
iamsoQ.sleep()
iamsoQ.introduce()

class Person {
    var firstName: String
    var lastName: String
    var fullName: String

    init() {
        firstName = "haha"
        lastName = "dao"
        fullName = firstName + " " + lastName
        print("a person \(fullName) is being initialized")
    }

    deinit {
        print("a person \(fullName) is being deinitialized")
    }
}

// var p1: Person? = Person()
// p1?.firstName
// p1?.firstName = "Sunny"
//// call deinit
// p1 = nil
//
//// init -> deinit
// Person()

class Heart {
    weak var person: Person?

    init() {
        print("a heart is being initialized")
    }

    deinit {
        print("a heart is being deinitialized")
    }
}

var p: Person? = Person()
var h: Heart? = Heart()

h?.person = p

p = nil
// h = nil
