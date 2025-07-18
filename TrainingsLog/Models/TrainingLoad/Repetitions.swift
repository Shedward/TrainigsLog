//
//  Repetitions.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct Repetitions: TrainingLoadRepresentable {

    var count: Int
    var loadPerRep: Double

    var totalLoad: Double {
        Double(count) * loadPerRep
    }

    var workingLoad: Double {
        Double(count)
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch format {
        case .full:
            count.formatted()
        case .workingLoad:
            count.formatted()
        case .multiplier:
            loadPerRep.formatted()
        }
    }
}
