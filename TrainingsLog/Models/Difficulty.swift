//
//  Difficulty.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import Foundation

struct Difficulty: Codable, RawRepresentable, CaseIterable, Hashable {

    static let normal = Difficulty(rawValue: 0)

    static var allCases: [Difficulty] {
        [.init(rawValue: -1), normal, .init(rawValue: 1), .init(rawValue: 2), .init(rawValue: 3)]
    }

    var rawValue: Int

    var displayValue: String {
        switch rawValue {
        case ...(-1):
            String(localized: "Too easy")
        case 0:
            String(localized: "Normal")
        case 1:
            String(localized: "Not easy")
        case 2:
            String(localized: "Hard")
        case 3...:
            String(localized: "Too hard")
        default:
            rawValue.formatted()
        }
    }

    init(rawValue: Int) {
        self.rawValue = rawValue
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(Int.self)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
