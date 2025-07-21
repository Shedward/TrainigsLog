//
//  TrainingLoadSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct TrainingLoadSelector: View {

    let exerciseLoadStats: ExerciseLoadStats?
    let onSelect: (TrainingLoad) -> Void
    let onDelete: (() -> Void)?

    @Environment(\.dismiss) var dismiss

    @State private var trainingLoad: TrainingLoad

    init(
        selected: TrainingLoad = .zero,
        exerciseLoadStats: ExerciseLoadStats?,
        onSelect: @escaping (TrainingLoad) -> Void,
        onDelete: (() -> Void)? = nil
    ) {
        self._trainingLoad = .init(initialValue: selected)
        self.exerciseLoadStats = exerciseLoadStats
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
                if let increment = exerciseLoadStats?.increment, !increment.isZero {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            trainingLoad += increment
                        } label: {
                            Label(increment.formatted(.increased), systemImage: "arrow.up")
                        }
                        Text(increment.formatted(.value))
                        Button {
                            trainingLoad -= increment
                        } label: {
                            Label(increment.formatted(.decreased), systemImage: "arrow.down")
                        }
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
