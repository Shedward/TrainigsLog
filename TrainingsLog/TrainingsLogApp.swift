//
//  TrainingsLogApp.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI
import SwiftData
import Foundation
import OSLog

@main
struct TrainingsLogApp: App {
    let sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([
            Muscle.self,
            Exercise.self,
            MuscleLoad.self,
            Training.self,
            TrainingSession.self,
            TrainingKind.self
        ])

        let url = URL.documentsDirectory.appending(path: "TrainingsLog.sqlite")
        Logger().info("Load database from \(url)")
        let modelConfiguration = ModelConfiguration(schema: schema, url: url)

        do {
            self.sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Trainings", systemImage: "checklist.unchecked") {
                    TrainingSessionsList()
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
        .environment(ErrorHandler())
    }
}
