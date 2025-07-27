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

    var body: some View {
        List {
            Group {
                if let kind = trainingSession.kind {
                    VStack(alignment: .leading) {
                        sessionsPlot(kind)
                            .padding(.horizontal)
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let kind = trainingSession.kind {
                    kindCell(kind)
                }
            }
        }
    }

    private func sessionsPlot(_ kind: TrainingKind) -> some View {
        Chart(sessionsWithSameKind) { session in
            BarMark(
                x: .value("Date", session.date),
                y: .value("Value", session.totalLoad.value)
            )
            .foregroundStyle(
                (kind.glyph?.tint.color ?? .accentColor)
                    .opacity(session.id == trainingSession.id ? 1.0 : 0.5)
            )
        }
        .chartXAxis {
            AxisMarks(format: .dateTime.day())
        }
        .chartYAxis(.hidden)
    }

    @ViewBuilder
    private func kindCell(_ kind: TrainingKind) -> some View {
        HStack {
            if let glyph = kind.glyph {
                GlyphImage(glyph: glyph, size: 24, cornerRadius: 16)
            }
            Text(kind.name)
                .font(.body.bold())
        }
        .foregroundStyle(kind.glyph?.tint.color ?? .primary)
        .task {
            errorHandler.try {
                guard let kind = trainingSession.kind else { return }
                sessionsWithSameKind = try modelContext.trainingCalendar.lastSessions(for: kind)
            }
        }
    }
}
