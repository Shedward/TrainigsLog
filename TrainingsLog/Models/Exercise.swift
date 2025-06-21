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

    var muscleGroup: MuscleGroup

    init(name: String, muscleGroup: MuscleGroup) {
        self.name = name
        self.muscleGroup = muscleGroup
    }
}

