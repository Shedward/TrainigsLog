//
//  TrainingsLogApp.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI
import SwiftData

@main
struct TrainingsLogApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MuscleGroup.self,
            Exercise.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Trainings Log", systemImage: "checklist.unchecked") {
                    TrainingsList()
                }
                Tab("ExercisesList", systemImage: "figure.strengthtraining.traditional") {
                    ExercisesList()
                }
                Tab("Muscle Groups", systemImage: "figure") {
                    MuscleGroupList()
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
