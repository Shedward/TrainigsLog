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

    case raw(RawLoad)
    case weights(Weights)
    case addingWeights(AddingWeights)
    case negativeWeights(NegativeWeights)
    case distance(Distance)
    case repetitions(Repetitions)

    var isZero: Bool {
        totalLoad == 0
    }

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

extension TrainingLoad {
    static let zero = TrainingLoad.raw(.zero)

    static func + (lhs: TrainingLoad, rhs: TrainingLoad) -> TrainingLoad? {
        switch (lhs, rhs) {
        case let (.raw(lhs), .raw(rhs)):
            .raw(lhs + rhs)
        case let (.addingWeights(lhs), .addingWeights(rhs)):
            .addingWeights(lhs + rhs)
        case let (.weights(lhs), .weights(rhs)):
            .weights(lhs + rhs)
        case let (.negativeWeights(lhs), .negativeWeights(rhs)):
            .negativeWeights(lhs + rhs)
        case let (.distance(lhs), .distance(rhs)):
            .distance(lhs + rhs)
        case let (.repetitions(lhs), .repetitions(rhs)):
            .repetitions(lhs + rhs)
        default:
            .none
        }
    }

    static func - (lhs: TrainingLoad, rhs: TrainingLoad) -> TrainingLoad? {
        switch (lhs, rhs) {
        case let (.raw(lhs), .raw(rhs)):
            .raw(lhs - rhs)
        case let (.addingWeights(lhs), .addingWeights(rhs)):
            .addingWeights(lhs - rhs)
        case let (.weights(lhs), .weights(rhs)):
            .weights(lhs - rhs)
        case let (.negativeWeights(lhs), .negativeWeights(rhs)):
            .negativeWeights(lhs - rhs)
        case let (.distance(lhs), .distance(rhs)):
            .distance(lhs - rhs)
        case let (.repetitions(lhs), .repetitions(rhs)):
            .repetitions(lhs - rhs)
        default:
            .none
        }
    }

    static func += (lhs: inout TrainingLoad, rhs: TrainingLoadIncrement) {
        if
            let increment = rhs.increment,
            let result = lhs + increment
        {
            lhs = result
        }
    }

    static func -= (lhs: inout TrainingLoad, rhs: TrainingLoadIncrement) {
        if
            let increment = rhs.increment,
            let result = lhs - increment
        {
            lhs = result
        }
    }
}

extension TrainingLoad: Defaultable {
    static var `default`: Self {
        .raw(.zero)
    }
}
