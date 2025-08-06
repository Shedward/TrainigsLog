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
    @State private var normalRestingInterval: TimeInterval?

    var body: some View {
        List {
            TrainingSessionsPlot(
                kind: trainingSession.kind,
                trainingSession: trainingSession,
                sessions: sessionsWithSameKind
            )
            .listRowSeparator(.hidden)
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
            }
        }
    }
}
