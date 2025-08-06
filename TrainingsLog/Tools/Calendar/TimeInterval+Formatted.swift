//
//  TimeInterval+Helpers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import Foundation

extension TimeInterval {
    var duration: Duration {
        .seconds(self)
    }

    func formatted(_ format: Duration.TimeFormatStyle) -> String {
        duration.formatted(format)
    }
}
