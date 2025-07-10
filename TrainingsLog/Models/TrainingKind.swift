//
//  TrainingKind.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import TrainingsLogMacro
import SwiftData

@Model
@Dataable
final class TrainingKind {
    var name: String
    var tint: Tint?

    init(name: String = "", tint: Tint? = nil) {
        self.name = name
        self.tint = tint
    }
}

extension TrainingKind: Defaultable {
    static var `default`: Self {
        .init()
    }
}
