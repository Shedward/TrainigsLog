//
//  TrainingSessionBlockCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import SwiftUI

struct TrainingSessionBlockCell: View {
    let exerciseBlock: TrainingSessionExercises.ExerciseBlock

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(exerciseBlock.exercise?.name ?? String(localized: "-"))
                    .font(.headline)
                if let sets = ListFormatter()
                    .string(from: exerciseBlock.sets.map { $0.load.formatted(.full) }) {
                    Text(sets)
                        .font(.body)
                }
            }
        }
    }
}
