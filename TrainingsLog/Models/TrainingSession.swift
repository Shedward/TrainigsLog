//
//  TrainingSession.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import Foundation
import SwiftData

@Model
class TrainingSession {
    var date: Date
    var trainings: [Training]
    var difficulty: Difficulty
    var comment: String?

    init(
        date: Date = Date(),
        trainings: [Training] = [],
        difficulty: Difficulty = .normal,
        comment: String? = nil
    ) {
        self.date = date
        self.trainings = trainings
        self.difficulty = difficulty
        self.comment = comment
    }
}

