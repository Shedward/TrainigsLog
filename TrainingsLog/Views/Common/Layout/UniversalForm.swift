//
//  UniversalForm.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI

struct UniversalForm<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        Form {
            content
        }
        #if os(macOS)
        .padding()
        #endif
    }
}
