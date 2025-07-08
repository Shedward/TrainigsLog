//
//  ExercisePicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftUI

struct ExercisePicker: View {
    @Binding var selection: Exercise?
    @Binding var openEditor: Exercise?

    var body: some View {
        ModelPicker(
            name: "Exercise",
            field: \Exercise.name,
            selection: $selection,
            openEditor: $openEditor
        ) { exercise in
            ExerciseCell(exercise: exercise)
        } createScreen: {
            EditExercise()
        }
    }
}


