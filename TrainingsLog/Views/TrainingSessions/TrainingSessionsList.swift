//
//  TrainingSessionsList.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 28.06.2025.
//

import SwiftUI
import SwiftData

struct TrainingSessionsList: View {

    @Query(sort: \TrainingSession.date, animation: .default)
    var trainingSessions: [TrainingSession] = []

    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) private var errorHandler

    @State private var openEditSessionSheet: TrainingSession?

    var body: some View {
        NavigationStack {
            List(trainingSessions) { session in
                Cell {
                    TrainingSessionCell(trainingSession: session)
                } onTap: {
                    openEditSessionSheet = session
                }
                .listRowSeparator(.hidden)
                .listRowInsetsMultiplatform(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .swipeActions {
                    Button.delete {
                        withAnimation {
                            errorHandler.try {
                                try session.delete()
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button.add {
                        openEditSessionSheet = TrainingSession()
                    }
                }
            }
            .navigationTitle("Training Sessions")
        }
        .sheet(item: $openEditSessionSheet) { session in
            EditTrainingSession(trainingSession: session)
        }
    }
}
