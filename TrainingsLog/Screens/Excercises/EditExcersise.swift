//
//  CreateExcersise.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI
import SwiftData

struct EditExercise: View {

    @Bindable private var exercise: Exercise

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(ErrorHandler.self) private var errorHandler

    @State private var openAddMuscleLoad: Bool = false

    init(exercise: Exercise = .init(name: "")) {
        self._exercise = .init(exercise)
    }

    var body: some View {
        NavigationStack {
            UniversalForm {
                TextField("Name", text: $exercise.name)

                Section("Muscles") {
                    ForEach(exercise.muscleLoads) { muscleLoad in
                        MuscleLoadCell(muscleLoad: muscleLoad)
                            .swipeActions {
                                Button.delete {
                                    withAnimation {
                                        errorHandler.try {
                                            modelContext.delete(muscleLoad)
                                            exercise.muscleLoads.removeAll { $0.id == muscleLoad.id }
                                        }
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
                ToolbarItem(placement: .cancellationAction) {
                    Button.cancel {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button.save {
                        errorHandler.try {
                            try modelContext.transaction {
                                modelContext.insert(exercise)
                                exercise.muscleLoads.forEach { modelContext.insert($0) }
                            }
                            dismiss()
                        }
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(exercise.name.isEmpty)
                }
            }
        }
        .sheet(isPresented: $openAddMuscleLoad) {
            MuscleSelector { newMuscle in
                let load = MuscleLoad(muscle: newMuscle, exercise: exercise)
                exercise.muscleLoads.append(load)
            }
        }
        .presentationDetents([.medium, .large])
    }
}
