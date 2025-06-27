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
        HStack(alignment: .lastTextBaseline) {
            Text(training.exercise?.name ?? String(localized: "-"))
            Spacer()
            VStack {
                Text(training.load.displayValue)
                    .bold()
                Text(training.workingLoad.formatted(.number.precision(.fractionLength(2))))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
