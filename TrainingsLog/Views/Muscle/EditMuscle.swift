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

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    init(muscle: Muscle = Muscle(name: "")) {
        self._muscle = .init(muscle)
    }

    var body: some View {
        BottomSheet("Muscle") {
            UniversalForm {
                TextField("Name", text: $muscle.name)
                TextField("Category", text: $muscle.category.unwrappedOr(""))
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        modelContext.insert(muscle)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(muscle.name.isEmpty)
                }
            }
        }
        .presentationDetents([.fraction(0.25), .large])
    }
}
