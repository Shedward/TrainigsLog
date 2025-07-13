//
//  TimeInterval+Helpers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 13.07.2025.
//

import Foundation

extension TimeInterval {

    static let second: TimeInterval = 1
    static let minute: TimeInterval = 60
    static let hour: TimeInterval = minute * 60
    static let day: TimeInterval = hour * 24
    static let week: TimeInterval = day * 7
    static let month: TimeInterval = day * 28
}
