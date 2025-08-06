//
//  Untitled.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import SwiftUI

struct TrainingSessionSummary: View {
    let trainingSession: TrainingSession

    var body: some View {
        HStack {
            InfoBox(
                value: trainingSession.interval?.duration.formatted(.time(pattern: .hourMinute)),
                title: String(localized: "Duration")
            )
            InfoBox(
                value: trainingSession.difficulty.displayValue,
                title: String(localized: "Difficulty")
            )
            Spacer()
            InfoBox(
                value: trainingSession.totalLoad.formatted(),
                title: String(localized: "Load")
            )
            .bold()
        }
    }
}

#Preview {
    TrainingSessionSummary(trainingSession: TrainingSession.mock1)
}
