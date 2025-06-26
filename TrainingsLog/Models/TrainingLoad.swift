//
//  TrainingLoad.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftData
import Foundation

protocol TrainingLoadRepresentable: Codable {
    var totalLoad: Double { get }
    var workingLoad: Double { get }
    var displayValue: String { get }
}

enum TrainingLoad: TrainingLoadRepresentable, Codable {

    static let zero = TrainingLoad.raw(.init(value: .zero))

    case raw(Raw)
    case weights(Weights)
    case negativeWeight(NegativeWeights)
    case distance(Distance)
    case repetitions(Repetitions)

    var totalLoad: Double {
        switch self {
        case .raw(let value):
            value.totalLoad
        case .weights(let value):
            value.totalLoad
        case .negativeWeight(let value):
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
        case .negativeWeight(let value):
            value.workingLoad
        case .distance(let value):
            value.workingLoad
        case .repetitions(let value):
            value.workingLoad
        }
    }

    var displayValue: String {
        switch self {
        case .raw(let value):
            value.displayValue
        case .weights(let value):
            value.displayValue
        case .negativeWeight(let value):
            value.displayValue
        case .distance(let value):
            value.displayValue
        case .repetitions(let value):
            value.displayValue
        }
    }

    struct Raw: TrainingLoadRepresentable {
        var value: WeightValue

        var totalLoad: Double {
            value.value
        }
        
        var workingLoad: Double {
            value.value
        }

        var displayValue: String {
            value.formatted()
        }
    }

    struct Weights: TrainingLoadRepresentable {
        var weight: WeightValue
        var reps: Int

        var totalLoad: Double {
            return Double(reps) * weight.value
        }

        var workingLoad: Double {
            weight.value
        }

        var displayValue: String {
            "\(reps) x \(weight.formatted()))"
        }
    }

    struct NegativeWeights: TrainingLoadRepresentable {
        var bodyWeight: WeightValue
        var negativeWeight: WeightValue
        var reps: Int

        var totalLoad: Double {
            (bodyWeight - negativeWeight).value * Double(reps)
        }

        var workingLoad: Double {
            (bodyWeight - negativeWeight).value
        }

        var displayValue: String {
            "\(reps) x \(negativeWeight.formatted())"
        }
    }

    struct Distance: TrainingLoadRepresentable {
        var distance: DistanceValue
        var loadPerMeter: Double

        var totalLoad: Double {
            distance.value * loadPerMeter
        }

        var workingLoad: Double {
            distance.value
        }

        var displayValue: String {
            distance.formatted()
        }
    }

    struct Repetitions: TrainingLoadRepresentable {
        var count: Int
        var loadPerRep: Double

        var totalLoad: Double {
            Double(count) * loadPerRep
        }

        var workingLoad: Double {
            Double(count)
        }

        var displayValue: String {
            count.formatted(.number)
        }
    }
}


struct WeightValue: Codable {
    var value: Double

    static let zero = Self(value: 0)

    static func - (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value - rhs.value)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    func formatted(_ formatStyle: WeightValueFormatStyle = .init()) -> String {
        formatStyle.format(self)
    }
}

struct DistanceValue: Codable {
    var value: Double

    static let zero = Self(value: 0)

    func formatted(_ formatStyle: DistanceValueFormatStyle = .init()) -> String {
        formatStyle.format(self)
    }
}

struct WeightValueFormatStyle: FormatStyle {
    public func format(_ value: WeightValue) -> String {
        Measurement(value: value.value, unit: UnitMass.kilograms).formatted(.measurement(width: .abbreviated))
    }
}

struct DistanceValueFormatStyle: FormatStyle {
    public func format(_ value: DistanceValue) -> String {
        Measurement(value: value.value, unit: UnitLength.meters).formatted(.measurement(width: .abbreviated))
    }
}
