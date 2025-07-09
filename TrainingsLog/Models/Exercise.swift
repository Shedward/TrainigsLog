//
//  Exercise.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import TrainingsLogMacro
import SwiftUI
import SwiftData

@Model
@ModelData
class Exercise {
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .cascade, inverse: \MuscleLoad.exercise) var muscleLoads: [MuscleLoad]

    init(name: String = "", muscleLoads: [MuscleLoad] = []) {
        self.name = name
        self.muscleLoads = muscleLoads
    }

    func delete(in modelContext: ModelContext? = nil) throws {
        guard let modelContext = modelContext ?? self.modelContext else {
            throw AppError("Model context not found")
        }

        try modelContext.transaction {
            for muscleLoad in muscleLoads {
                modelContext.delete(muscleLoad)
            }
            modelContext.delete(self)
        }
    }
}

