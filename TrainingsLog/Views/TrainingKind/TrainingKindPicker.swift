//
//  TrainingKindPicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI


struct TrainingKindPicker: View {
    @Binding var selection: TrainingKind?

    var body: some View {
        ModelPicker(
            name: "Training Kind",
            field: \TrainingKind.name,
            selection: $selection
        ) { kind in
            TrainingKindCell(kind: kind)
        } createScreen: {
            EditTrainingKind()
        }
    }
}
