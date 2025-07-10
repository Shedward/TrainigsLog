//
//  CreateExcersise.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI
import SwiftData

struct EditExercise: View {

    private let exerciseModel: Exercise

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(ErrorHandler.self) private var errorHandler

    @State private var exerciseData: Exercise.Data
    @State private var openAddMuscleLoad: Bool = false

    init(exercise: Exercise = .default) {
        self.exerciseModel = exercise
        self._exerciseData = .init(initialValue: exercise.data())
    }

    var body: some View {
        BottomSheet("Exercise") {
            UniversalForm {
                TextField("Name", text: $exerciseData.name)

                Section("Muscles") {
                    ForEach(exerciseData.muscleLoads) { muscleLoad in
                        MuscleLoadCell(muscleLoad: muscleLoad)
                            .swipeActions {
                                Button.delete {
                                    withAnimation {
                                        exerciseData.muscleLoads.removeAll { $0.id == muscleLoad.id }
                                    }
                                }
                            }
                    }
                    Button.add {
                        openAddMuscleLoad = true
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        errorHandler.try {
                            try modelContext.transaction {
                                exerciseModel.save(data: exerciseData)
                                modelContext.insert(exerciseModel)
                                exerciseModel.muscleLoads.forEach { modelContext.insert($0) }
                            }
                            dismiss()
                        }
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(exerciseData.name.isEmpty)
                }
            }
        }
        .sheet(isPresented: $openAddMuscleLoad) {
            MuscleSelector { newMuscle in
                let load = MuscleLoad(muscle: newMuscle, exercise: exerciseModel)
                exerciseData.muscleLoads.append(load)
            }
        }
        .presentationDetents([.medium, .large])
    }
}
