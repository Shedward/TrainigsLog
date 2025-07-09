//
//  TrainingSession.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import TrainingsLogMacro
import Foundation
import SwiftData

@Model
@ModelData
class TrainingSession {
    var date: Date
    var kind: TrainingKind?
    var trainings: [Training]
    var difficulty: Difficulty
    var comment: String?

    var totalLoad: WeightValue {
        let value = trainings.map(\.load.totalLoad).reduce(0, +)
        return WeightValue(value: value)
    }

    var groupedTrainings: TrainingGroups {
        TrainingGroups(grouping: trainings)
    }

    init(
        date: Date = Date(),
        kind: TrainingKind? = nil,
        trainings: [Training] = [],
        difficulty: Difficulty = .normal,
        comment: String? = nil
    ) {
        self.date = date
        self.kind = kind
        self.trainings = trainings
        self.difficulty = difficulty
        self.comment = comment
    }

    func delete(in modelContext: ModelContext? = nil) throws {
        guard let modelContext = self.modelContext else {
            throw AppError("Model сontext not found")
        }

        modelContext.delete(self)
    }
}
