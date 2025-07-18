import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AdditiveArithmeticMacros: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        var vars: [(name: String, type: String, isOptional: Bool)] = []

        for member in decl.memberBlock.members {
            guard let varDecl = member.decl.as(VariableDeclSyntax.self),
                  varDecl.bindings.count == 1,
                  let binding = varDecl.bindings.first,
                  let ident = binding.pattern.as(IdentifierPatternSyntax.self),
                  let typeAnn = binding.typeAnnotation?.type,
                  binding.accessor == nil
            else { continue }

            let name = ident.identifier.text
            let typeString = typeAnn.description.trimmingCharacters(in: .whitespacesAndNewlines)
            let isOptional = typeString.hasSuffix("?")
            let cleanType = typeString.replacingOccurrences(of: "?", with: "")

            vars.append((name, cleanType, isOptional))
        }

        guard let namedSyntax = decl as? NamedDeclSyntax else {
            return []
        }
        let modelName = namedSyntax.name.text

        let zeroInit = vars.map { varInfo in
            "       \(varInfo.name): .zero,"
        }.joined(separator: "\n")

        let plusInit = vars.map { varInfo in
            "       \(varInfo.name): lhs.\(varInfo.name) + rhs.\(varInfo.name),"
        }.joined(separator: "\n")

        let minusInit = vars.map { varInfo in
            "       \(varInfo.name): lhs.\(varInfo.name) - rhs.\(varInfo.name),"
        }.joined(separator: "\n")

        let declSyntax: DeclSyntax = """
        extension \(raw: modelName): AdditiveArithmetic {
        
            static var zero: Self {
                .init(
        \(raw: zeroInit)
                )
            }
            
            static func + (lhs: Self, rhs: Self) -> Self {
                .init(
        \(raw: plusInit)
                )
            }
        
            static func - (lhs: Self, rhs: Self) -> Self {
                .init(
        \(raw: minusInit)
                )
            }
        }
        """

        guard let extensionDecl = declSyntax.as(ExtensionDeclSyntax.self) else {
          return []
        }

        return [extensionDecl]
    }
}
