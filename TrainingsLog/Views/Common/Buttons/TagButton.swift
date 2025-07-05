//
//  TagButton.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI

struct TagButton<Label: View>: View {
    let label: Label
    let onTap: () -> Void

    init(onTap: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.onTap = onTap
    }


    var body: some View {
        Button {
            onTap()
        } label: {
            label
        }
        .buttonStyle(.plain)
        .padding(4)
        .background(Color(.tertiarySystemFill))
        .clipShape(Capsule())
    }
}

struct TagLabel: View {
    var text: String

    var body: some View {
        Text(text)
            .padding(.horizontal, 4)
    }
}

extension TagButton {

    static func add(_ onTap: @escaping () -> Void) -> Self where Label == Image {
        TagButton {
            onTap()
        } label: {
            Image(systemName: "plus")
        }
    }

    init(_ text: String, onTap: @escaping () -> Void) where Label == TagLabel {
        self.init {
            onTap()
        } label: {
            TagLabel(text: text)
        }
    }
}

#Preview {
    HStack {
        TagButton("Add", onTap: {})
        TagButton.add {}
    }
    .padding()
}
