//
//  Muscle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftData

@Model
class Muscle {
    @Attribute(.unique) var name: String

    var category: String?

    init(name: String, category: String? = nil) {
        self.name = name
        self.category = category
    }
}
