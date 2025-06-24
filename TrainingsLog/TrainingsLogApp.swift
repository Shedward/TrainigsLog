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
            Muscle.self,
            Exercise.self,
            MuscleLoad.self
        ])

        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Trainings", systemImage: "checklist.unchecked") {
                    TrainingsList()
                }
                Tab("Exercises", systemImage: "figure.strengthtraining.traditional") {
                    ExercisesList()
                }
                Tab("Muscles", systemImage: "figure") {
                    MusclesList()
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
