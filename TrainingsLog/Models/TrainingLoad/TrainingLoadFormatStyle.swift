//
//  TrainingLoadFormatStyle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

enum TrainingLoadFormatStyle: FormatStyle {
    case full
    case workingLoad
    case multiplier

    func format(_ value: TrainingLoad) -> String {
        value.formatted(self)
    }
}
