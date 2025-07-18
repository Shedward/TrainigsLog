//
//  Distance.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct Distance: TrainingLoadRepresentable {

    var distance: DistanceValue
    var loadPerMeter: Double

    var totalLoad: Double {
        distance.value * loadPerMeter
    }

    var workingLoad: Double {
        distance.value
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch format {
        case .full:
            distance.formatted()
        case .workingLoad:
            distance.value.formatted()
        case .multiplier:
            loadPerMeter.formatted()
        }
    }
}
