//
//  Calendar+DaysOfTheWeek.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.07.2025.
//

import Foundation

extension Calendar {
    func daysOfTheWeek(startDate: Date) -> [DateInterval] {
        guard let weekInterval = self.dateInterval(of: .weekOfYear, for: startDate) else {
            return []
        }

        var intervals: [DateInterval] = []

        for offset in 0..<7 {
            if let dayStart = date(byAdding: .day, value: offset, to: weekInterval.start),
               let dayInterval = dateInterval(of: .day, for: dayStart) {
                intervals.append(dayInterval)
            }
        }

        return intervals
    }
}
