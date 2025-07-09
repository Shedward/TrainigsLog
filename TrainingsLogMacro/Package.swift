// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "TrainingsLogMacro",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "TrainingsLogMacro",
            targets: ["TrainingsLogMacro"]
        ),
        .executable(
            name: "TrainingsLogMacroClient",
            targets: ["TrainingsLogMacroClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "601.0.0-latest"),
    ],
    targets: [
        .macro(
            name: "TrainingsLogMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(name: "TrainingsLogMacro", dependencies: ["TrainingsLogMacroMacros"]),
        .executableTarget(name: "TrainingsLogMacroClient", dependencies: ["TrainingsLogMacro"]),
    ]
)
