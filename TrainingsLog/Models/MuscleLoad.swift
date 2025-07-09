//
//  MuscleLoad.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 23.06.2025.
//

import TrainingsLogMacro
import SwiftData

@Model
@ModelData
class MuscleLoad {
    var muscle: Muscle?
    var exercise: Exercise?
    var loadFraction: Double

    init(muscle: Muscle, exercise: Exercise, loadFraction: Double = 1.0) {
        self.muscle = muscle
        self.exercise = exercise
        self.loadFraction = loadFraction
    }
}
