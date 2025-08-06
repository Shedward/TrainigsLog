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
final class TrainingSession {
    var date: Date
    var kind: TrainingKind?
    var trainings: [Training]
    var difficulty: Difficulty
    var comment: String?

    var totalLoad: WeightValue {
        let value = trainings.map(\.load.totalLoad).reduce(0, +)
        return WeightValue(value: value)
    }

    var interval: DateInterval? {
        let startDate = trainings.compactMap(\.interval?.start).min()
        let endDate = trainings.compactMap(\.interval?.end).max()

        if let startDate, let endDate, startDate <= endDate {
            return DateInterval(start: startDate, end: endDate)
        } else {
            return nil
        }
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

extension TrainingSession: Dataable {
    struct Data {
        var date: Date
        var kind: TrainingKind?
        var exercises: TrainingSessionExercises
        var difficulty: Difficulty
        var comment: String?
    }

    func data() -> Data {
        Data(
            date: date,
            kind: kind,
            exercises: TrainingSessionExercises(trainingSession: self),
            difficulty: difficulty,
            comment: comment
        )
    }

    func save(data: Data) {
        self.date = data.date
        self.kind = data.kind
        self.trainings = data.exercises.blocks
            .flatMap(\.sets)
            .enumerated()
            .map { index, set in
                let training = set.training
                training.trainingSession = self
                training.orderInSession = index
                training.load = set.load
                training.startDate = training.startDate ?? date
                return training
            }
        self.difficulty = data.difficulty
        self.comment = data.comment
    }
}

extension TrainingSession: Defaultable {
    static var `default`: Self {
        .init()
    }
}
