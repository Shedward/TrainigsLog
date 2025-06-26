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
    @State private var openCreateTrainingSheet: Bool = false

    var body: some View {
        NavigationStack {
            List(trainings) { training in
                TrainingCell(training: training)
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
                        openCreateTrainingSheet = true
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .animation(.default, value: trainings)
        }
        .sheet(isPresented: $openCreateTrainingSheet) {
            EditTraining()
        }
    }
}
