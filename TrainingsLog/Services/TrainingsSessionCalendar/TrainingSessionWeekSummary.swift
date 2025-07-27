//
//  TrainingSessionWeek.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 22.07.2025.
//

import Foundation

struct TrainingSessionWeekSummary {
    let days: [DaySummary]
    let maxLoad: WeightValue?

    init(days: [DaySummary]) {
        self.days = days
        self.maxLoad = days
            .flatMap { [ $0.currentLoad ?? .zero, $0.previousLoad ?? .zero ] }
            .max { $0.value < $1.value }
    }

    struct DaySummary {
        let date: Date
        let kinds: [TrainingKind]
        let previousLoad: WeightValue?
        let currentLoad: WeightValue?
    }
}
