
struct SizeStruct {
    var width: Float = 5.0
    var height: Float = 8.0

    func area() -> Float {
        return width * height
    }
}

var aSize: SizeStruct = SizeStruct(width: 20.0, height: 30.0)
aSize.width
aSize.height
aSize.area()
aSize.width = 30
aSize.area()

struct SizeClass {
    var width: Float = 5.0
    var height: Float = 8.0

    func area() -> Float {
        return width * height
    }
}

// subclass and superclass
// reference type (class) vs value type (struct)

var sizeClass = SizeClass(width: 20, height: 30)
sizeClass.area()
