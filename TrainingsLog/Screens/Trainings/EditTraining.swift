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
        NavigationStack {
            UniversalForm {
                DatePicker("Date", selection: $training.date)
                ExercisePicker(selection: $training.exercise)
                TrainingLoadPicker(trainingLoad: $training.load)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button.cancel {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .primaryAction) {
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
