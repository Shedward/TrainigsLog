//
//  DatabaseExerciseLoadStatsService.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 13.07.2025.
//

import Foundation
import SwiftData

final class ExerciseLoadStatsService {
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func workingLoadStats(for exercise: Exercise) throws -> ExerciseLoadStats {
        let exerciseId = exercise.id
        let isTrainingWithExercise = #Predicate<Training> { it in
            it.exercise?.persistentModelID == exerciseId
        }

        var getTrainingWithExercise = FetchDescriptor(
            predicate: isTrainingWithExercise,
            sortBy: [
                SortDescriptor(\Training.startDate, order: .reverse),
                SortDescriptor(\Training.orderInSession, order: .reverse)
            ]
        )
        getTrainingWithExercise.fetchLimit = 30
        let trainings = try modelContext.fetch(getTrainingWithExercise)
        return Self.workingLoadStats(for: trainings)
    }

    static func workingLoadStats(for trainings: [Training]) -> ExerciseLoadStats {
        let lastLoad = trainings.first?.load ?? .zero
        let workingLoad = trainings.map(\.load).max { $0.totalLoad < $1.totalLoad } ?? .zero

        let firstIncreasingIncrement = trainings
            .pairs()
            .lazy
            .map { TrainingLoadIncrement(from: $1.load, to: $0.load) }
            .filter { $0.isIncreasing }
            .first

        let lastSession = trainings
            .prefixSame(\.trainingSession)
            .map(\.load)

        return ExerciseLoadStats(
            lastLoad: lastLoad,
            workingLoad: workingLoad,
            increment: firstIncreasingIncrement,
            lastSession: Array(lastSession)
        )
    }
}

extension ModelContext {
    func exerciseLoadStats(for exercise: Exercise) throws -> ExerciseLoadStats {
        try ExerciseLoadStatsService(modelContext: self).workingLoadStats(for: exercise)
    }
}
