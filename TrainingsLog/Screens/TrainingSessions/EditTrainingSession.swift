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

    init(trainingSession: TrainingSession) {
        self._trainingSession = .init(trainingSession)
    }

    var body: some View {
        NavigationStack {
            UniversalForm {
                DatePicker("Date", selection: $trainingSession.date)
                TextField("Name", text: $trainingSession.name.unwrappedOr(""))

                Section("State") {
                    DifficultyPicker($trainingSession.difficulty)
                    TextEditor(text: $trainingSession.comment.unwrappedOr(""))
                }
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button.cancel {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button.save {
                        modelContext.insert(trainingSession)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
    }
}
