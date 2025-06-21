//
//  Cell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 21.06.2025.
//

import SwiftUI

struct Cell<Content: View>: View {
    var content: Content
    var role: ButtonRole?
    var onTap: () -> Void

    init(@ViewBuilder content: () -> Content, role: ButtonRole? = nil, onTap: @escaping () -> Void) {
        self.content = content()
        self.role = role
        self.onTap = onTap
    }

    var body: some View {
        Button(role: role) {
            onTap()
        } label: {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
