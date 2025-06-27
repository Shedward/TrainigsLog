//
//  DifficultyPicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import SwiftUI

struct DifficultyPicker: View {
    @Binding var selection: Difficulty

    init(_ selection: Binding<Difficulty>) {
        self._selection = selection
    }

    var body: some View {
        Picker("Difficulty", selection: $selection) {
            ForEach(Difficulty.allCases, id: \.rawValue) { difficulty in
                Text(difficulty.displayValue).tag(difficulty)
            }
        }
    }
}

#Preview {
    DifficultyPicker(.constant(.normal))
}
