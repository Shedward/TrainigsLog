//
//  TrainingCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import SwiftUI

struct TrainingCell: View {
    let training: Training

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(training.exercise?.name ?? String(localized: "-"))
                .bold()
            Spacer()
            VStack(alignment: .trailing) {
                Text(training.load.displayValue)
                    .bold()
                Text(training.load.totalLoad.formatted(.number))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(minHeight: 32)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}
