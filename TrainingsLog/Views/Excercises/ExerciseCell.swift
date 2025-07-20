//
//  ExerciseCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI

struct ExerciseCell: View {
    let exercise: Exercise

    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) var errorHandler

    @State private var musclesDescription: String?

    init(exercise: Exercise) {
        self.exercise = exercise
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.body.bold())

                if let musclesDescription {
                    Text(musclesDescription)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .frame(minHeight: 32)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .onChange(of: exercise, initial: true) { _, _ in
            updateMusclesDescription()
        }
    }

    private func updateMusclesDescription() {
        musclesDescription = exercise.muscleLoads
            .sorted(using: SortDescriptor(\.loadFraction, order: .forward))
            .compactMap(\.muscle?.name)
            .joined(separator: ", ")
    }
}
