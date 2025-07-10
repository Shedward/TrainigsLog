import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct TrainingsLogMacroPlugin: CompilerPlugin {
    let providingMacros: [any Macro.Type] = [
        DataableMacro.self
    ]
}
