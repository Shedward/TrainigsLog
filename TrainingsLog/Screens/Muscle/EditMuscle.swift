//
//  EditMuscle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct EditMuscle: View {

    @Bindable var muscle: Muscle

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    init(muscle: Muscle = Muscle(name: "")) {
        self._muscle = .init(muscle)
    }

    var body: some View {
        NavigationStack {
            UniversalForm {
                TextField("Name", text: $muscle.name)
                TextField("Category", text: $muscle.category.unwrappedOr(""))
            }
            .toolbar {
                Spacer()
                Button.cancel {
                    dismiss()
                }
                Button.save {
                    modelContext.insert(muscle)
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(muscle.name.isEmpty)
            }
        }
        .presentationDetents([.fraction(0.25), .large])
    }
}
