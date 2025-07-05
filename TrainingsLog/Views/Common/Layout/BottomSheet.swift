//
//  BottomSheet.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    let title: LocalizedStringKey
    var content: Content

    @Environment(\.dismiss) private var dismiss

    init(_ title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.title = title
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
