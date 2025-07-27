//
//  TrainingWeeklyCalendar.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.07.2025.
//

import SwiftUI

struct TrainingWeeklyCalendar: View {
    @Environment(\.modelContext) var modelContext

    @State private var summaries: [TrainingSessionWeekSummary] = []

    var body: some View {
        BottomSheet("Weekly calendar") {
            List(summaries, id: \.days.first?.interval) { summary in
                TrainingSessionWeekBar(summary: summary)
                    .listRowInsets(EdgeInsets(top: 12, leading: 4, bottom: 16, trailing: 4))
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .task {
                let startDate = Date()
                let weeksCount = 12

                for weekOffset in 0..<weeksCount {
                    let date = startDate.addingTimeInterval(-Double(weekOffset) * 7 * 24 * 60 * 60)
                    if let summary = try? modelContext.trainingCalendar.weekSummary(for: date) {
                        summaries.append(summary)
                    }
                }
            }
        }
    }
}
