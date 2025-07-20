//
//  BottomSheet.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    let title: Text
    var content: Content

    @Environment(\.dismiss) private var dismiss

    init(_ key: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.title = Text(key)
        self.content = content()
    }

    @_disfavoredOverload
    init<S: StringProtocol>(_ title: S, @ViewBuilder content: () -> Content) {
        self.title = Text(title)
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button.cancel {
                            dismiss()
                        }
                    }
                }
                .navigationTitle(title)
                #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
        }
    }
}
