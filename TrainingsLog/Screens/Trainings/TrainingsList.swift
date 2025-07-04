//
//  Trainings.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct TrainingsList: View {

    @Query(sort: \Training.date, animation: .default)
    var trainings: [Training] = []

    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) private var errorHandler
    @State private var openEditTrainingSheet: Training?

    var body: some View {
        NavigationStack {
            List(trainings) { training in
                Cell {
                    TrainingCell(training: training)
                } onTap: {
                    openEditTrainingSheet = training
                }
                .swipeActions {
                    Button.delete {
                        withAnimation {
                            errorHandler.try {
                                try training.delete()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button.add {
                        openEditTrainingSheet = Training()
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .navigationTitle("Trainings")
            .animation(.default, value: trainings)
        }
        .sheet(item: $openEditTrainingSheet) { training in
            EditTraining(training: training)
        }
    }
}
