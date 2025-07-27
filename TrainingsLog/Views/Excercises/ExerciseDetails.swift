//
//  ExerciseDetails.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import SwiftUI

struct ExerciseDetails: View {
    let exercise: Exercise

    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) var errorHandler

    @State private var loadStats: ExerciseLoadStats?

    var body: some View {
        BottomSheet(exercise.name) {
            UniversalForm {
                if let loadStats {
                    LabeledContent("Last load", value: loadStats.lastLoad.formatted(.full))
                    LabeledContent("Working load", value: loadStats.workingLoad.formatted(.full))
                    LabeledContent("Increment", value: (loadStats.increment?.increment ?? .zero).formatted(.workingLoad))
                    LabeledContent("Last session") {
                        HStack {
                            ForEach(loadStats.lastSession, id: \.self) { load in
                                Text(load.formatted(.workingLoad))
                            }
                        }
                    }
                }
            }
        }
        .task {
            fetchStats()
        }
    }

    private func fetchStats() {
        errorHandler.try {
            self.loadStats = try modelContext.exerciseLoadStatsService
                .workingLoadStats(for: exercise)
        }
    }
}
