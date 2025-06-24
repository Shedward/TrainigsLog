//
//  ExerciseCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI

struct ExerciseCell: View {
    let exercise: Exercise

    @State private var musclesDescription: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.name)
                .font(.body.bold())

            if let musclesDescription {
                Text(musclesDescription)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(minHeight: 32)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .onAppear {
            updateMusclesDescription()
        }
        .onChange(of: exercise) { _, _ in
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
