//
//  TrainingKind.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import TrainingsLogMacro
import SwiftData

@Model
@ModelData
class TrainingKind {
    var name: String
    var tint: Tint?

    init(name: String = "", tint: Tint? = nil) {
        self.name = name
        self.tint = tint
    }
}
