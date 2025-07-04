//
//  ExerciseSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct ExerciseSelector: View {
    @State private var selection: Exercise?
    let onSelect: (Exercise) -> Void

    init(onSelect: @escaping (Exercise) -> Void) {
        self.onSelect = onSelect
    }

    var body: some View {
        ModelSelector(
            name: "Exercise",
            field: \Exercise.name,
            selection: $selection
        ) { exercise in
            ExerciseCell(exercise: exercise)
        } createScreen: {
            EditExercise()
        } onSelect: { exercise in
            onSelect(exercise)
        }
    }
}
