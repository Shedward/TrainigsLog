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
    @State private var loadStats: ExerciseLoadStats?

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
            Spacer()
            if let loadStats {
                VStack(alignment: .trailing) {
                    Text(loadStats.workingLoad.formatted(.full))
                        .font(.body.monospacedDigit().bold())
                    Text(loadStats.lastLoad.formatted(.full))
                        .font(.body.monospacedDigit())
                }
            }
        }
        .frame(minHeight: 32)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .onAppear {
            updateMusclesDescription()
            updateExerciseLoadStats()
        }
        .onChange(of: exercise) { _, _ in
            updateMusclesDescription()
            updateExerciseLoadStats()
        }
    }

    private func updateMusclesDescription() {
        musclesDescription = exercise.muscleLoads
            .sorted(using: SortDescriptor(\.loadFraction, order: .forward))
            .compactMap(\.muscle?.name)
            .joined(separator: ", ")
    }

    private func updateExerciseLoadStats() {
        errorHandler.try {
            let stats = try ExerciseLoadStatsService(modelContext: modelContext)
                .workingLoadStats(for: exercise)
            loadStats = stats
        }
    }
}
