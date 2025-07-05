//
//  EditTrainingSession.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI
import SwiftData

struct EditTrainingSession: View {

    @Bindable var trainingSession: TrainingSession

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var groupedTrainings: GroupedTrainings {
        didSet {
            trainingSession.trainings = groupedTrainings.allTrainings
        }
    }
    @State private var openExerciseSelector = false

    init(trainingSession: TrainingSession) {
        self._trainingSession = .init(trainingSession)
        self._groupedTrainings = .init(initialValue: .init(grouping: trainingSession.trainings))
    }

    var body: some View {
        BottomSheet("Training Session") {
            UniversalForm {
                DatePicker("Date", selection: $trainingSession.date)
                TextField("Name", text: $trainingSession.name.unwrappedOr(""))

                Section("Exercises") {
                    ForEach(groupedTrainings.groups) { group in
                        TrainingGroupCell(
                            trainingGroup: group,
                            onAddLoad: {
                                let lastLoad = group.trainings.last?.load ?? .zero
                                let newTraining = Training(trainingSession: trainingSession, exercise: group.exercise, load: lastLoad)
                                groupedTrainings.addTraining(newTraining, to: group)
                            },
                            onDelete: { deletingTraining in
                                groupedTrainings.deleteTraining(deletingTraining, from: group)
                            }
                        )
                        .swipeActions {
                            Button.delete {
                                groupedTrainings.deleteGroup(group)
                            }
                        }
                    }
                    Button.add {
                        openExerciseSelector = true
                    }
                }

                Section("State") {
                    DifficultyPicker($trainingSession.difficulty)
                    TextEditor(text: $trainingSession.comment.unwrappedOr(""))
                }
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        modelContext.insert(trainingSession)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
        .sheet(isPresented: $openExerciseSelector) {
            ExerciseSelector { addExercise in
                let training = Training(trainingSession: trainingSession, exercise: addExercise)
                groupedTrainings.newGroup(training)
            }
        }
    }
}
