import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ModelDataMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = decl.as(ClassDeclSyntax.self) else {
            return []
        }

        var vars: [(name: String, type: String, isOptional: Bool)] = []

        for member in classDecl.memberBlock.members {
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

        let modelName = classDecl.identifier.text

        let properties = vars.map { varInfo in
            "    var \(varInfo.name): \(varInfo.type)\(varInfo.isOptional ? "?" : "")"
        }.joined(separator: "\n")

        let initLines = vars.map { varInfo in
            "        self.\(varInfo.name) = model.\(varInfo.name)"
        }.joined(separator: "\n")

        let applyLines = vars.map { varInfo in
            "    \(varInfo.name) = data.\(varInfo.name)"
        }.joined(separator: "\n")

        let structDecl = """
        struct Data {
        \(properties)

            init(from model: \(modelName)) {
        \(initLines)
            }
        }
        
        func data() -> Data {
            Data(from: self)
        }
        
        func save(data: Data) {
        \(applyLines)
        }
        """

        return [try DeclSyntax(stringLiteral: structDecl)]
    }
}
