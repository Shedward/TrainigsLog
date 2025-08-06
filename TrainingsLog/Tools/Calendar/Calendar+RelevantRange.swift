//
//  Date+RelevantRange.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import Foundation

extension Date {
    enum RelevancePosition: Double {
        case start = 0.0
        case middle = -0.5
        case end = -1.0
    }

    func relevantRange(of interval: TimeInterval, position: RelevancePosition = .middle) -> DateInterval {
        DateInterval(start: addingTimeInterval(position.rawValue * interval), duration: interval)
            .limitedByToday()
    }
}

extension DateInterval {

    func limitedByToday() -> DateInterval {
        limited(maxEndDate: Date())
    }

    func limited(maxEndDate: Date) -> DateInterval {
        guard end > maxEndDate else {
            return self
        }

        return DateInterval(start: end.addingTimeInterval(-duration), duration: duration)
    }
}
