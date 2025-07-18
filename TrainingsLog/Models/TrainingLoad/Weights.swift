//
//  Weights.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct Weights: TrainingLoadRepresentable {

    var weight: WeightValue
    var reps: Int

    var totalLoad: Double {
        return Double(reps) * weight.value
    }

    var workingLoad: Double {
        weight.value
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch format {
        case .full:
            String(localized: "\(weight.formatted()) ×\(reps.formatted())")
        case .workingLoad:
            weight.value.formatted()
        case .multiplier:
            reps.formatted()
        }
    }
}
