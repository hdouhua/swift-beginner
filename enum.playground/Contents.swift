enum Direction {
    case east
    case west
    case south
    case north
}

Direction.east
Direction.north

let myDirection = Direction.east
func whichDirectionToGo(direction: Direction) {
    switch direction {
    case .east:
        print("east")
    default:
        print("no direction")
    }
}

whichDirectionToGo(direction: myDirection)

enum Season {
    case spring
    case summer
    case autum
    case winter
}

// Error handler
enum NameInputError: Error {
    case empty
    case isNumber
}

func getFullName(firstName: String, lastName: String) throws -> String {
    if firstName == "" || lastName == "" {
        throw NameInputError.empty
    } else if Int(firstName) != nil || Int(lastName) != nil {
        throw NameInputError.isNumber
    }

    let fullName = firstName + " " + lastName
    return fullName
}

do {
    try getFullName(firstName: "123", lastName: "dao")
} catch NameInputError.empty {
    print("empty name")
} catch NameInputError.isNumber {
    print("is a number")
}
