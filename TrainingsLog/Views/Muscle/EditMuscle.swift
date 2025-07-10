//
//  EditMuscle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct EditMuscle: View {

    private let muscleModel: Muscle

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var muscleData: Muscle.Data

    init(muscle: Muscle = .default) {
        self.muscleModel = muscle
        self._muscleData = .init(initialValue: muscle.data())
    }

    var body: some View {
        BottomSheet("Muscle") {
            UniversalForm {
                TextField("Name", text: $muscleData.name)
                TextField("Category", text: $muscleData.category.unwrappedOr(""))
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        muscleModel.save(data: muscleData)
                        modelContext.insert(muscleModel)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(muscleData.name.isEmpty)
                }
            }
        }
        .presentationDetents([.fraction(0.25), .large])
    }
}
