//
//  SessionsPlot.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import SwiftUI
import Charts

struct TrainingSessionsPlot: View {
    let kind: TrainingKind?
    let trainingSession: TrainingSession?
    let sessions: [TrainingSession]

    var body: some View {
        Chart(sessions) { session in
            let color = (kind?.glyph?.tint.color ?? .accentColor)
                .opacity(session.id == trainingSession?.id ? 1.0 : 0.5)

            BarMark(
                x: .value("Date", session.date),
                y: .value("Value", session.totalLoad.value)
            )
            .foregroundStyle(color)
        }
        .chartXAxis {
            AxisMarks(format: .dateTime.day())
        }
        .chartYAxis(.hidden)
        .chartScrollableAxes(.horizontal)
        .chartScrollPosition(initialX: trainingSession?.date ?? Date())
        .chartXVisibleDomain(length: TimeInterval.month)
        .chartPlotStyle { content in
            content.padding(.horizontal)
        }
    }
}
