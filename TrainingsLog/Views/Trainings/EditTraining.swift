//
//  EditTraining.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftData
import SwiftUI

struct EditTraining: View {

    private let trainingModel: Training

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var trainingData: Training.Data
    @State private var openExerciseEditor: Exercise?

    init(training: Training = Training()) {
        self.trainingModel = training
        self._trainingData = .init(initialValue: training.data())
    }

    var body: some View {
        BottomSheet("Training") {
            UniversalForm {
                DatePicker("Date", selection: $trainingData.startDate.unwrappedOr(Date()))
                ExercisePicker(selection: $trainingData.exercise, openEditor: $openExerciseEditor)
                TrainingLoadPicker(trainingLoad: $trainingData.load)

                Section("State") {
                    DifficultyPicker($trainingData.difficulty)
                    LabeledContent("Comment") {
                        TextEditor(text: $trainingData.comment.unwrappedOr(""))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        trainingModel.save(data: trainingData)
                        modelContext.insert(trainingModel)
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
