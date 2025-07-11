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
    var glyph: Glyph?

    init(name: String = "", tint: Tint? = nil, glyph: Glyph? = nil) {
        self.name = name
        self.tint = tint
        self.glyph = glyph
    }
}

extension TrainingKind: Defaultable {
    static var `default`: Self {
        .init()
    }
}
