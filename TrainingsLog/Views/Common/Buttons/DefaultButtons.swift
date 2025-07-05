//
//  Button+Defaults.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 22.06.2025.
//

import SwiftUI

extension Button {

    static func add(_ action: @escaping () -> Void) -> Self where Label == SwiftUI.Label<Text, Image> {
        Button("Add", systemImage: "plus", action: action)
    }

    static func save(_ action: @escaping () -> Void) -> Self where Label == SwiftUI.Label<Text, Image> {
        Button("Save", systemImage: "checkmark", action: action)
    }

    static func done(_ action: @escaping () -> Void) -> Self where Label == SwiftUI.Label<Text, Image> {
        Button("Done", systemImage: "checkmark", action: action)
    }

    static func cancel(_ action: @escaping () -> Void) -> Self where Label == SwiftUI.Label<Text, Image> {
        Button("Cancel", systemImage: "xmark", role: .cancel, action: action)
    }

    static func delete(_ action: @escaping () -> Void) -> Self where Label == SwiftUI.Label<Text, Image> {
        Button("Delete", systemImage: "trash", role: .destructive, action: action)
    }
}
