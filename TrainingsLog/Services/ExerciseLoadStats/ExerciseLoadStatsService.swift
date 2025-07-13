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

        var getTrainingWithExercise = FetchDescriptor(predicate: isTrainingWithExercise, sortBy: [SortDescriptor(\Training.startDate, order: .reverse)])
        getTrainingWithExercise.fetchLimit = 10
        let trainings = try modelContext.fetch(getTrainingWithExercise)

        let lastLoad = trainings.first?.load ?? .zero
        let workingLoad = trainings.map(\.load).max { $0.totalLoad < $1.totalLoad } ?? .zero

        return ExerciseLoadStats(
            lastLoad: lastLoad,
            workingLoad: workingLoad
        )
    }
}
