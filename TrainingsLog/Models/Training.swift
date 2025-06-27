//
//  Training.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftData
import Foundation

@Model
class Training {
    var date: Date
    var exercise: Exercise?

    private(set) var totalLoad: Double = 0
    private(set) var workingLoad: Double = 0

    var load: TrainingLoad {
        didSet {
            totalLoad = load.totalLoad
            workingLoad = load.workingLoad
        }
    }

    init(date: Date = Date(), exercise: Exercise? = nil, load: TrainingLoad = .zero) {
        self.date = date
        self.exercise = exercise
        self.load = load
    }

    func delete(in modelContext: ModelContext? = nil) throws {
        guard let modelContext = self.modelContext else {
            throw AppError("Model сontext not found")
        }

        modelContext.delete(self)
    }
}
