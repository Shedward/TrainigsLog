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

    var body: some View {
        NavigationStack {
            List(trainingSessions) { session in

            }
        }
    }
}
