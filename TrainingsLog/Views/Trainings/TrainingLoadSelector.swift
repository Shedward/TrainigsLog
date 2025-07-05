//
//  TrainingLoadSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct TrainingLoadSelector: View {

    let onSelect: (TrainingLoad) -> Void
    let onDelete: (() -> Void)?

    @Environment(\.dismiss) var dismiss

    @State private var trainingLoad: TrainingLoad

    init(
        selected: TrainingLoad = .zero,
        onSelect: @escaping (TrainingLoad) -> Void,
        onDelete: (() -> Void)? = nil
    ) {
        self._trainingLoad = .init(initialValue: selected)
        self.onSelect = onSelect
        self.onDelete = onDelete
    }

    var body: some View {
        BottomSheet("Training Load") {
            UniversalForm {
                TrainingLoadPicker(trainingLoad: $trainingLoad)
            }.toolbar {
                if let onDelete {
                    ToolbarItem(placement: .destructiveAction) {
                        Button.delete {
                            onDelete()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        onSelect(trainingLoad)
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
