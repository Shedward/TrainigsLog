//
//  WeightValue.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import TrainingsLogMacro
import Foundation


@AdditiveArithmetic
struct WeightValue: Codable, Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
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

    func formatted(_ formatStyle: WeightValueFormatStyle = .init()) -> String {
        formatStyle.format(self)
    }
}

struct WeightValueFormatStyle: FormatStyle {
    public func format(_ value: WeightValue) -> String {
        String(localized: "\(value.value.formatted()) kg")
    }
}
