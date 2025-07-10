
//
//  Defaultable.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 10.07.2025.
//

import TrainingsLogMacro

protocol Defaultable {
    static var `default`: Self { get }
}
