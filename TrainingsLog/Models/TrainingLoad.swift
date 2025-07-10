//
//  TrainingLoad.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftUI
import SwiftData
import Foundation

protocol TrainingLoadRepresentable: Codable, Equatable {
    var totalLoad: Double { get }
    var workingLoad: Double { get }

    func formatted(_ format: TrainingLoadFormatStyle) -> String
}

enum TrainingLoad: TrainingLoadRepresentable {

    static let zero = TrainingLoad.raw(.init(value: .zero))

    case raw(Raw)
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

    struct Raw: TrainingLoadRepresentable {

        static let zero = Self(value: .zero)

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

    struct Weights: TrainingLoadRepresentable {

        static let zero = Self(weight: .zero, reps: 0)

        var weight: WeightValue
        var reps: Int

        var totalLoad: Double {
            return Double(reps) * weight.value
        }

        var workingLoad: Double {
            weight.value
        }

        func formatted(_ format: TrainingLoadFormatStyle) -> String {
            switch format {
            case .full:
                String(localized: "\(weight.formatted()) ×\(reps.formatted())")
            case .workingLoad:
                weight.value.formatted()
            case .multiplier:
                reps.formatted()
            }
        }
    }

    struct NegativeWeights: TrainingLoadRepresentable {

        static let zero = Self(bodyWeight: .zero, negativeWeight: .zero, reps: 0)

        var bodyWeight: WeightValue
        var negativeWeight: WeightValue
        var reps: Int

        var totalLoad: Double {
            (bodyWeight - negativeWeight).value * Double(reps)
        }

        var workingLoad: Double {
            (bodyWeight - negativeWeight).value
        }

        func formatted(_ format: TrainingLoadFormatStyle) -> String {
            switch format {
            case .full:
                String(localized: "-\(negativeWeight.formatted()) ×\(reps)")
            case .workingLoad:
                (-negativeWeight.value).formatted()
            case .multiplier:
                reps.formatted()
            }
        }
    }

    struct AddingWeights: TrainingLoadRepresentable {

        static let zero = Self(initialWeight: .zero, weight: .zero, reps: 0)

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

    struct Distance: TrainingLoadRepresentable {

        static let zero = Self(distance: .zero, loadPerMeter: 0)

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

    struct Repetitions: TrainingLoadRepresentable {

        static let zero = Self(count: 0, loadPerRep: 0)

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

enum TrainingLoadFormatStyle: FormatStyle {
    case full
    case workingLoad
    case multiplier

    func format(_ value: TrainingLoad) -> String {
        value.formatted(self)
    }
}


struct WeightValue: Codable, Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    var value: Double

    static let zero = Self(value: 0)

    static func - (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value - rhs.value)
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        .init(value: lhs.value + rhs.value)
    }

    init(value: Double) {
        self.value = value
    }

    init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.value = Double(value)
    }

    func formatted(_ formatStyle: WeightValueFormatStyle = .init()) -> String {
        formatStyle.format(self)
    }
}

struct DistanceValue: Codable, Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    var value: Double

    static let zero = Self(value: 0)

    init(value: Double) {
        self.value = value
    }

    init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.value = Double(value)
    }

    func formatted(_ formatStyle: DistanceValueFormatStyle = .init()) -> String {
        formatStyle.format(self)
    }
}

struct WeightValueFormatStyle: FormatStyle {
    public func format(_ value: WeightValue) -> String {
        String(localized: "\(value.value.formatted()) kg")
    }
}

struct DistanceValueFormatStyle: FormatStyle {
    public func format(_ value: DistanceValue) -> String {
        String(localized: "\(value.value.formatted()) m")
    }
}

extension TrainingLoad: Defaultable {
    static var `default`: Self {
        .raw(.zero)
    }
}
