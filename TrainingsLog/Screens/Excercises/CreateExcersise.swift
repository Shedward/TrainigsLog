//
//  CreateExcersise.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI
import SwiftData

struct CreateExercise: View {

    private struct CreateMuscleLoad: Identifiable {
        let id: UUID = UUID()
        var muscle: Muscle
        var loadFraction: Double
    }

    @State private var name: String = ""
    @State private var muscleLoads: [CreateMuscleLoad] = []
    @State private var openAddMuscleLoad: Bool = false

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            UniversalForm {
                TextField("Name", text: $name)

                Section("Muscles") {
                    ForEach(muscleLoads) { muscleLoad in
                        // TODO: Replace
                        MuscleCell(muscle: muscleLoad.muscle)
                    }
                    Button.add {
                        openAddMuscleLoad = true
                    }
                }
            }
            .toolbar {
                Spacer()
                Button.cancel {
                    dismiss()
                }
                Button.save {
                    let exercise = Exercise(name: name)
                    let muscleLoads = self.muscleLoads
                        .map { MuscleLoad(muscle: $0.muscle, exercise: exercise, loadFraction: $0.loadFraction) }

                    modelContext.insert(exercise)
                    muscleLoads.forEach { modelContext.insert($0) }

                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(name.isEmpty)
            }
        }
        .sheet(isPresented: $openAddMuscleLoad) {
            MuscleSelector { newMuscle in
                muscleLoads.append(CreateMuscleLoad(muscle: newMuscle, loadFraction: 1.0))
            }
        }
        .presentationDetents([.medium, .large])
    }
}
