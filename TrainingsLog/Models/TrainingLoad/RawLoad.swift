//
//  RawLoad.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct RawLoad: TrainingLoadRepresentable {
    var value: WeightValue

    var totalLoad: Double {
        value.value
    }

    var workingLoad: Double {
        value.value
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch format {
        case .full:
            value.formatted()
        case .workingLoad:
            value.value.formatted()
        case .multiplier:
            ""
        }
    }
}
