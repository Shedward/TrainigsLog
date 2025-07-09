//
//  Training.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import TrainingsLogMacro
import SwiftData
import Foundation

@Model
@ModelData
class Training {
    var date: Date
    var trainingSession: TrainingSession?
    var exercise: Exercise?
    var load: TrainingLoad
    var difficulty: Difficulty
    var comment: String?

    init(
        date: Date = Date(),
        trainingSession: TrainingSession? = nil,
        exercise: Exercise? = nil,
        load: TrainingLoad = .zero,
        difficulty: Difficulty = .normal,
        comment: String? = nil
    ) {
        self.date = date
        self.trainingSession = trainingSession
        self.exercise = exercise
        self.load = load
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
