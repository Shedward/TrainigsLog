//
//  TrainingGroupCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftData
import SwiftUI

struct TrainingGroupCell: View {
    let trainingGroup: TrainingGroups.Group
    let onAddLoad: () -> Void
    let onDelete: (Training) -> Void

    @Binding var openTrainingLoadEditor: Training?

    var body: some View {
        VStack(alignment: .leading) {
            Text(trainingGroup.exercise?.name ?? String(localized: "-"))
            ScrollView(.horizontal) {
                HStack {
                    ForEach(trainingGroup.trainings) { training in
                        TagButton(training.load.formatted(.full)) {
                            openTrainingLoadEditor = training
                        }
                    }
                    TagButton.add {
                        onAddLoad()
                    }
                }
            }.scrollIndicators(.hidden)
        }
        .sheet(item: $openTrainingLoadEditor) { training in
            TrainingLoadSelector(selected: training.load) { newLoad in
                training.load = newLoad
            } onDelete: {
                onDelete(training)
            }
        }
    }
}
