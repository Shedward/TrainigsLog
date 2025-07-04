//
//  TrainingGroupCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

struct TrainingGroupCell: View {
    let trainingGroup: GroupedTrainings.Group

    var body: some View {
        Text(trainingGroup.exercise?.name ?? String(localized: "-"))
    }
}
