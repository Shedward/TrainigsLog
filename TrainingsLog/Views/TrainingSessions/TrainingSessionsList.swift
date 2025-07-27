//
//  TrainingSessionsList.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 28.06.2025.
//

import SwiftUI
import SwiftData

struct TrainingSessionsList: View {

    @Query(sort: \TrainingSession.date, order: .reverse, animation: .default)
    var trainingSessions: [TrainingSession] = []

    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) private var errorHandler

    @State private var openEditSessionSheet: TrainingSession?
    @State private var openWeeklyCalendar: Bool = false
    @State private var weekSummary: TrainingSessionWeekSummary?

    var body: some View {
        NavigationStack {
            List {
                if let weekSummary {
                    Cell {
                        TrainingSessionWeekBar(summary: weekSummary)
                    } onTap: {
                        openWeeklyCalendar = true
                    }
                    .listRowSeparator(.hidden)
                }
                ForEach(trainingSessions) { session in
                    Cell {
                        TrainingSessionCell(trainingSession: session)
                    } onTap: {
                        openEditSessionSheet = session
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsetsMultiplatform(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .swipeActions {
                        Button.delete {
                            withAnimation {
                                errorHandler.try {
                                    try session.delete()
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button.add {
                        openEditSessionSheet = TrainingSession()
                    }
                }
            }
        }
        .sheet(item: $openEditSessionSheet) { session in
            EditTrainingSession(trainingSession: session)
        }
        .sheet(isPresented: $openWeeklyCalendar) {
            TrainingWeeklyCalendar()
        }
        .onChange(of: trainingSessions, initial: true) { _, _ in
            fetchWeekSummary()
        }
    }

    private func fetchWeekSummary() {
        errorHandler.try {
            weekSummary = try modelContext.trainingCalendar.weekSummary()
        }
    }
}
