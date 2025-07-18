//
//  DistanceValue.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation

@AdditiveArithmetic
struct DistanceValue: Codable, Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    var value: Double

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

struct DistanceValueFormatStyle: FormatStyle {
    public func format(_ value: DistanceValue) -> String {
        String(localized: "\(value.value.formatted()) m")
    }
}
