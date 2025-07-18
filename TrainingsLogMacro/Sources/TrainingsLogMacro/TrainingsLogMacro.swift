
import Foundation

public protocol Dataable {
    associatedtype Data

    func data() -> Data
    func save(data: Data)
}

@attached(extension, conformances: Dataable, names: arbitrary)
public macro Dataable() = #externalMacro(
    module: "TrainingsLogMacroMacros",
    type: "DataableMacro"
)

@attached(extension, conformances: AdditiveArithmetic, names: arbitrary)
public macro AdditiveArithmetic() = #externalMacro(
    module: "TrainingsLogMacroMacros",
    type: "AdditiveArithmeticMacros"
)
