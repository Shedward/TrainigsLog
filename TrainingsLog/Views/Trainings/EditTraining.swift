//
//  EditTraining.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftData
import SwiftUI

struct EditTraining: View {

    @Bindable var training: Training

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    init(training: Training = Training()) {
        self._training = .init(training)
    }

    var body: some View {
        BottomSheet("Training") {
            UniversalForm {
                DatePicker("Date", selection: $training.date)
                ExercisePicker(selection: $training.exercise)
                TrainingLoadPicker(trainingLoad: $training.load)

                Section("State") {
                    DifficultyPicker($training.difficulty)
                    LabeledContent("Comment") {
                        TextEditor(text: $training.comment.unwrappedOr(""))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        modelContext.insert(training)
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
