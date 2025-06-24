//
//  Muscle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftData

@Model
class Muscle {
    @Attribute(.unique) var name: String
    var category: String?
    @Relationship(deleteRule: .cascade, inverse: \MuscleLoad.muscle) var muscleLoads: [MuscleLoad]

    init(name: String, category: String? = nil, muscleLoads: [MuscleLoad] = []) {
        self.name = name
        self.category = category
        self.muscleLoads = muscleLoads
    }
}
