//
//  TrainingLoad.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import TrainingsLogMacro

import SwiftUI
import SwiftData
import Foundation

enum TrainingLoad: TrainingLoadRepresentable {

    static let zero = TrainingLoad.raw(.zero)

    case raw(RawLoad)
    case weights(Weights)
    case addingWeights(AddingWeights)
    case negativeWeights(NegativeWeights)
    case distance(Distance)
    case repetitions(Repetitions)

    var totalLoad: Double {
        switch self {
        case .raw(let value):
            value.totalLoad
        case .weights(let value):
            value.totalLoad
        case .addingWeights(let value):
            value.totalLoad
        case .negativeWeights(let value):
            value.totalLoad
        case .distance(let value):
            value.totalLoad
        case .repetitions(let value):
            value.totalLoad
        }
    }

    var workingLoad: Double {
        switch self {
        case .raw(let value):
            value.workingLoad
        case .weights(let value):
            value.workingLoad
        case .addingWeights(let value):
            value.workingLoad
        case .negativeWeights(let value):
            value.workingLoad
        case .distance(let value):
            value.workingLoad
        case .repetitions(let value):
            value.workingLoad
        }
    }

    func formatted(_ format: TrainingLoadFormatStyle) -> String {
        switch self {
        case .raw(let value):
            value.formatted(format)
        case .weights(let value):
            value.formatted(format)
        case .addingWeights(let value):
            value.formatted(format)
        case .negativeWeights(let value):
            value.formatted(format)
        case .distance(let value):
            value.formatted(format)
        case .repetitions(let value):
            value.formatted(format)
        }
    }

    enum Kind: CaseIterable {
        case raw
        case weight
        case addingWeight
        case negativeWeight
        case distance
        case repetitions

        init(_ load: TrainingLoad) {
            switch load {
            case .raw:
                self = .raw
            case .weights:
                self = .weight
            case .addingWeights:
                self = .addingWeight
            case .negativeWeights:
                self = .negativeWeight
            case .distance:
                self = .distance
            case .repetitions:
                self = .repetitions
            }
        }

        var displayName: LocalizedStringKey {
            switch self {
            case .raw:
                "Raw"
            case .weight:
                "Weight"
            case .addingWeight:
                "Adding weight"
            case .negativeWeight:
                "Negative weight"
            case .distance:
                "Distance"
            case .repetitions:
                "Repetitions"
            }
        }

        var defaultLoad: TrainingLoad {
            switch self {
            case .raw:
                TrainingLoad.raw(.zero)
            case .addingWeight:
                TrainingLoad.addingWeights(.zero)
            case .weight:
                TrainingLoad.weights(.zero)
            case .negativeWeight:
                TrainingLoad.negativeWeights(.zero)
            case .distance:
                TrainingLoad.distance(.zero)
            case .repetitions:
                TrainingLoad.repetitions(.zero)
            }
        }
    }
}

extension TrainingLoad: Defaultable {
    static var `default`: Self {
        .raw(.zero)
    }
}
