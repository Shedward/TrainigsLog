//
//  TrainingLoadByMuscleCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import SwiftUI

struct LoadByMuscleCell: View {
    let loadByMuscle: TrainingLoadByMuscle.LoadByMuscle

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(loadByMuscle.muscle.name)
                .font(.headline)
            Spacer()
            Text(loadByMuscle.load.formatted(.init(valueOnly: true)))
                .font(.headline)
        }
    }
}
