import TrainingsLogMacro

@Dataable
class TestClass {
    let id = 1
    var text: String = ""
    var count: Int = 0
}


@AdditiveArithmetic
struct TestValue {
    let value: Double
    let value2: Int
}

let value = TestValue.zero + .zero
