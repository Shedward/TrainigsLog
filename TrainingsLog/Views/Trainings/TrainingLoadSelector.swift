//
//  TrainingLoadSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct TrainingLoadSelector: View {

    let onSelect: (TrainingLoad) -> Void

    @Environment(\.dismiss) var dismiss

    @State private var trainingLoad: TrainingLoad

    init(selected: TrainingLoad = .zero, onSelect: @escaping (TrainingLoad) -> Void) {
        self._trainingLoad = .init(initialValue: selected)
        self.onSelect = onSelect
    }

    var body: some View {
        BottomSheet("Training Load") {
            UniversalForm {
                TrainingLoadPicker(trainingLoad: $trainingLoad)
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        dismiss()
                        onSelect(trainingLoad)
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
