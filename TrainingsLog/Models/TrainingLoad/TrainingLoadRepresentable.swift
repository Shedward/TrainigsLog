//
//  TrainingLoadRepresentable.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

protocol TrainingLoadRepresentable: Codable, Hashable {
    var totalLoad: Double { get }
    var workingLoad: Double { get }

    func formatted(_ format: TrainingLoadFormatStyle) -> String
}
