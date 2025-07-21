//
//  TrainingLoadIncrement.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import Foundation

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

    var isZero: Bool {
        increment == nil
    }

    init(from: TrainingLoad, to: TrainingLoad) {
        self.from = from
        self.to = to
        self.increment = to - from
        self.totalLoadDifference = to.totalLoad - from.totalLoad
    }

    func formatted(_ style: TrainingLoadIncrementFormatStyle) -> String {
        guard let increment else {
            return String(localized: "No increment")
        }

        switch style {
        case .increased:
            return increment.workingLoad
                .formatted(
                    .number
                        .precision(.fractionLength(0...1))
                        .sign(strategy: .always(includingZero: false))
                )
        case .decreased:
            return (-increment.workingLoad)
                .formatted(
                    .number
                        .precision(.fractionLength(0...1))
                        .sign(strategy: .always(includingZero: false))
                )

        case .value:
            return increment.workingLoad
                .formatted(.number.precision(.fractionLength(0...1)))
        }
    }
}

enum TrainingLoadIncrementFormatStyle: FormatStyle {
    case increased
    case decreased
    case value

    func format(_ value: TrainingLoadIncrement) -> String {
        value.formatted(self)
    }
}
