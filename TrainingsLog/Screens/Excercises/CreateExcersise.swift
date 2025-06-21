//
//  CreateExcersise.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI
import SwiftData

struct CreateExercise: View {

    @State var name: String = ""
    @State var muscleGroup: MuscleGroup?

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            UniversalForm {
                TextField("Name", text: $name)
                ModelPicker(
                    name: "Muscle Group",
                    field: \MuscleGroup.name,
                    selection: $muscleGroup
                ) { muscleGroup in
                    MuscleGroupCell(muscleGroup: muscleGroup)
                }
            }
            .toolbar {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Add") {
                    guard let muscleGroup else {
                        return
                    }
                    let exercise = Exercise(name: name, muscleGroup: muscleGroup)
                    modelContext.insert(exercise)
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(name.isEmpty)
            }
        }
    }
}
