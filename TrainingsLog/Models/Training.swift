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
@Dataable
final class Training {
    var orderInSession: Int
    var startDate: Date?
    var duration: TimeInterval
    var trainingSession: TrainingSession?
    var exercise: Exercise?
    var load: TrainingLoad
    var difficulty: Difficulty
    var comment: String?

    init(
        orderInSession: Int = 0,
        startDate: Date? = nil,
        duration: TimeInterval = 0,
        trainingSession: TrainingSession? = nil,
        exercise: Exercise? = nil,
        load: TrainingLoad = .zero,
        difficulty: Difficulty = .normal,
        comment: String? = nil
    ) {
        self.orderInSession = orderInSession
        self.startDate = startDate
        self.duration = duration
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

extension Training: Defaultable {
    static var `default`: Self {
        .init()
    }
}
