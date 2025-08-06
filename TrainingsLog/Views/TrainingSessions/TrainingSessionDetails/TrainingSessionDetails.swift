//
//  TrainingSessionDetails.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.07.2025.
//

import SwiftUI
import Charts

struct TrainingSessionDetails: View {
    @Bindable var trainingSession: TrainingSession

    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) private var errorHandler

    @State private var sessionsWithSameKind: [TrainingSession] = []
    @State private var selectedDate: Date?
    @State private var exercises: TrainingSessionExercises?

    var body: some View {
        List {
            Section {
                TrainingSessionsPlot(
                    kind: trainingSession.kind,
                    trainingSession: trainingSession,
                    sessions: sessionsWithSameKind
                )
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                TrainingSessionSummary(trainingSession: trainingSession)
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            }
            .listRowSeparator(.hidden)

            if let exercises {
                Section("Exercises") {
                    ForEach(exercises.blocks) { block in
                        TrainingSessionBlockCell(exerciseBlock: block)
                    }
                }
            }

            Section("Muscles") {
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TrainingSessionTitle(trainingSession: trainingSession)
            }
        }
        .task {
            errorHandler.try {
                guard let kind = trainingSession.kind else { return }
                sessionsWithSameKind = try modelContext.trainingCalendar.lastSessions(for: kind)
                exercises = TrainingSessionExercises(trainingSession: trainingSession)
            }
        }
    }
}
