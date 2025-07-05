//
//  TintCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI

struct TintCell: View {
    let tint: Tint

    var body: some View {
        Circle()
            .foregroundStyle(tint.color)
            .frame(maxWidth: 32)
    }
}
