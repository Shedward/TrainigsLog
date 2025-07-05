//
//  Tint.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI

enum Tint: CaseIterable, Codable {
    case none
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case purple


    var color: Color {
        switch self {
            case .none: .black
            case .red: .red
            case .orange: .orange
            case .yellow: .yellow
            case .green: .green
            case .blue: .blue
            case .indigo: .indigo
            case .purple: .purple
        }
    }
}
