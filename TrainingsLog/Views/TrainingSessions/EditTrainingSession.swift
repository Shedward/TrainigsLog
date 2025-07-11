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
    @Environment(\.dismiss) private var dismiss

    @State private var trainingSessionData: TrainingSession.Data
    @State private var openExerciseSelector = false
    @State private var openTrainingKindEditor: TrainingKind?
    @State private var openTrainingLoadEditor: Training?

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
                    ForEach(trainingSessionData.trainingGroups.groups) { group in
                        TrainingGroupCell(
                            trainingGroup: group,
                            onAddLoad: {
                                let lastLoad = group.trainings.last?.load ?? .zero
                                let newTraining = Training(
                                    trainingSession: trainingSessionModel,
                                    exercise: group.exercise,
                                    load: lastLoad
                                )
                                trainingSessionData.trainingGroups.addTraining(newTraining, to: group)
                            },
                            onDelete: { deletingTraining in
                                trainingSessionData.trainingGroups.deleteTraining(deletingTraining, from: group)
                            },
                            openTrainingLoadEditor: $openTrainingLoadEditor
                        )
                        .swipeActions {
                            Button.delete {
                                trainingSessionData.trainingGroups.deleteGroup(group)
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
                let training = Training(exercise: addExercise)
                trainingSessionData.trainingGroups.newGroup(training)
            }
        }
    }
}
