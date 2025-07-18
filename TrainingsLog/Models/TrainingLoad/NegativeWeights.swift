//
//  NegativeWeights.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct NegativeWeights: TrainingLoadRepresentable {

    var bodyWeight: WeightValue
    var negativeWeight: WeightValue
    var reps: Int

    var totalLoad: Double {
        (bodyWeight - negativeWeight).value * Double(reps)
    }

    var workingLoad: Double {
        (bodyWeight - negativeWeight).value
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch format {
        case .full:
            String(localized: "-\(negativeWeight.formatted()) ×\(reps)")
        case .workingLoad:
            (-negativeWeight.value).formatted()
        case .multiplier:
            reps.formatted()
        }
    }
}
