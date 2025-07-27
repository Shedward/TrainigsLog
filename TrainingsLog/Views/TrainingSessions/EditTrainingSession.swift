//
//  EditTrainingSession.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI
import SwiftData

struct EditTrainingSession: View {

    private let trainingSessionModel: TrainingSession

    @Environment(\.modelContext) private var modelContext
    @Environment(ErrorHandler.self) private var errorHandler
    @Environment(\.dismiss) private var dismiss

    @State private var trainingSessionData: TrainingSession.Data
    @State private var openExerciseSelector = false
    @State private var openTrainingKindEditor: TrainingKind?
    @State private var openTrainingLoadEditor: TrainingSessionExercises.ExerciseSet?

    init(trainingSession: TrainingSession) {
        self.trainingSessionModel = trainingSession
        self._trainingSessionData = .init(initialValue: trainingSession.data())
    }

    var body: some View {
        BottomSheet("Training Session") {
            UniversalForm {
                DatePicker("Date", selection: $trainingSessionData.date)
                TrainingKindPicker(selection: $trainingSessionData.kind, openEditor: $openTrainingKindEditor)

                Section("Exercises") {
                    ForEach(trainingSessionData.exercises.blocks) { block in
                        ExerciseBlockCell(
                            exerciseBlock: block,
                            onSetSelected: { set in
                                openTrainingLoadEditor = set
                            },
                            onAddLoad: {
                                block.repeatSet()
                            }
                        )
                        .swipeActions {
                            Button.delete {
                                trainingSessionData.exercises.delete(block: block)
                            }
                        }
                    }
                    Button.add {
                        openExerciseSelector = true
                    }
                }

                Section("State") {
                    DifficultyPicker($trainingSessionData.difficulty)
                    TextEditor(text: $trainingSessionData.comment.unwrappedOr(""))
                }
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        trainingSessionModel.save(data: trainingSessionData)
                        modelContext.insert(trainingSessionModel)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
        .sheet(isPresented: $openExerciseSelector) {
            ExerciseSelector { addExercise in
                errorHandler.try {
                    let stats = try modelContext.exerciseLoadStatsService
                        .workingLoadStats(for: addExercise)
                    trainingSessionData.exercises.appendNewBlock(exercise: addExercise, exerciseStats: stats)
                }
            }
        }
        .sheet(item: $openTrainingLoadEditor) { set in
            TrainingLoadSelector(selected: set.load, exerciseLoadStats: set.block?.exerciseStats) { newLoad in
                set.load = newLoad
            } onDelete: {
                trainingSessionData.exercises.delete(set: set)
            }
        }
    }
}
