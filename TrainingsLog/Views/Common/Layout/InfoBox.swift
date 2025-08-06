//
//  InfoBox.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 30.07.2025.
//

import SwiftUI

struct InfoBox: View {
    let value: String?
    let title: String

    var body: some View {
        VStack(alignment: .trailing) {
            Text(value ?? String(localized: "-"))
                .font(.title2.monospacedDigit())
            Text(title)
                .font(.caption.smallCaps())
        }
        .padding(.horizontal)
    }
}

#Preview {
    HStack {
        InfoBox(value: nil, title: "Rest Rate")
        InfoBox(value: "15k", title: "Avg. Load")
        InfoBox(value: "21k", title: "Max. Load")
        Spacer()
        InfoBox(value: "24 300", title: "Load")
            .bold()
            .foregroundStyle(.red)
    }
}
