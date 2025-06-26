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
            Text(training.load.displayValue)
        }
    }
}
