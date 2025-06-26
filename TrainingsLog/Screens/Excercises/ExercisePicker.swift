//
//  ExercisePicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftUI

struct ExercisePicker: View {
    @Binding var selection: Exercise?

    var body: some View {
        ModelPicker(
            name: "Exercise",
            field: \Exercise.name,
            selection: $selection
        ) { exercise in
            ExerciseCell(exercise: exercise)
        } createScreen: {
            EditExercise()
        }
    }
}

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
