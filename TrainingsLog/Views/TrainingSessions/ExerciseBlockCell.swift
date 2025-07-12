//
//  ExerciseBlockCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftData
import SwiftUI

struct ExerciseBlockCell: View {
    let exerciseBlock: TrainingSessionExercises.ExerciseBlock

    let onSetSelected: (TrainingSessionExercises.ExerciseSet) -> Void
    let onAddLoad: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(exerciseBlock.exercise?.name ?? String(localized: "-"))
            ScrollView(.horizontal) {
                HStack {
                    ForEach(exerciseBlock.sets) { set in
                        TagButton(set.load.formatted(.full)) {
                            onSetSelected(set)
                        }
                    }
                    TagButton.add {
                        onAddLoad()
                    }
                }
            }.scrollIndicators(.hidden)
        }
    }
}
