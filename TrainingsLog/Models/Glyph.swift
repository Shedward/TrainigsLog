//
//  Glyph.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 11.07.2025.
//

struct Glyph: Codable {
    var icon: Icon?
    var tint: Tint

    init(icon: Icon? = nil, tint: Tint = .default) {
        self.icon = icon
        self.tint = tint
    }

    enum Icon: Codable {
        case systemImage(String)
        case text(String)
    }
}

extension Glyph: Defaultable {
    static var `default`: Self {
        Glyph(tint: .default)
    }
}
