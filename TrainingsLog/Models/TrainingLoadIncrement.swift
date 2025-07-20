//
//  TrainingLoadIncrement.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

struct TrainingLoadIncrement {
    let increment: TrainingLoad?
    let from: TrainingLoad
    let to: TrainingLoad

    let totalLoadDifference: Double
    var workingLoadDifference: Double {
        increment?.workingLoad ?? 0
    }

    var isIncreasing: Bool {
        totalLoadDifference > 0
    }

    init(from: TrainingLoad, to: TrainingLoad) {
        self.from = from
        self.to = to
        self.increment = to - from
        self.totalLoadDifference = to.totalLoad - from.totalLoad
    }
}
