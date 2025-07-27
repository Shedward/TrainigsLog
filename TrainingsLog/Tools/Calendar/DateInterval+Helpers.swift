//
//  TimeInterval+Helpers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.07.2025.
//

import Foundation

extension DateInterval {
    func addingTimeInterval(_ timeInterval: TimeInterval) -> DateInterval {
        return DateInterval(start: start.addingTimeInterval(timeInterval), duration: duration)
    }
}
