//
//  Exercise.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftData

@Model
class Exercise {
    @Attribute(.unique) var name: String
    @Relationship(inverse: \MuscleLoad.exercise) var muscleLoads: [MuscleLoad]

    init(name: String, muscleLoads: [MuscleLoad] = []) {
        self.name = name
        self.muscleLoads = muscleLoads
    }
}

