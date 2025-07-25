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
    var glyph: Glyph?

    init(name: String = "", glyph: Glyph? = nil) {
        self.name = name
        self.glyph = glyph
    }
}

extension TrainingKind: Defaultable {
    static var `default`: Self {
        .init()
    }
}
