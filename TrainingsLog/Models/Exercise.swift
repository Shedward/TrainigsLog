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

    var muscle: Muscle

    init(name: String, muscle: Muscle) {
        self.name = name
        self.muscle = muscle
    }
}

