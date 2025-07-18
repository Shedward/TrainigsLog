//
//  AddingWeights.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct AddingWeights: TrainingLoadRepresentable {

    var initialWeight: WeightValue
    var weight: WeightValue
    var reps: Int

    var totalLoad: Double {
        (initialWeight + weight).value * Double(reps)
    }

    var workingLoad: Double {
        (initialWeight + weight).value
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch format {
        case .full:
            String(localized: "+\(weight.formatted()) ×\(reps)")
        case .workingLoad:
            weight.value.formatted()
        case .multiplier:
            reps.formatted()
        }
    }
}
