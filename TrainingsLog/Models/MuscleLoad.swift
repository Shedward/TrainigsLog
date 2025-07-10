//
//  MuscleLoad.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 23.06.2025.
//

import TrainingsLogMacro
import SwiftData

@Model
@Dataable
final class MuscleLoad {
    var muscle: Muscle?
    var exercise: Exercise?
    var loadFraction: Double

    init(muscle: Muscle = .default, exercise: Exercise = .default, loadFraction: Double = 1.0) {
        self.muscle = muscle
        self.exercise = exercise
        self.loadFraction = loadFraction
    }
}

extension MuscleLoad: Defaultable {
    static var `default`: Self {
        .init()
    }
}
