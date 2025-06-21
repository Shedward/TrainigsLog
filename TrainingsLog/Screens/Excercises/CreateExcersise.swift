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
    @State var muscle: Muscle?

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            UniversalForm {
                TextField("Name", text: $name)
                ModelPicker(
                    name: "Muscle",
                    field: \Muscle.name,
                    selection: $muscle
                ) { muscle in
                    MuscleCell(muscle: muscle)
                } createScreen: {
                    CreateMuscle()
                }
            }
            .toolbar {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Add") {
                    guard let muscle else {
                        return
                    }
                    let exercise = Exercise(name: name, muscle: muscle)
                    modelContext.insert(exercise)
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(name.isEmpty)
            }
        }
    }
}
