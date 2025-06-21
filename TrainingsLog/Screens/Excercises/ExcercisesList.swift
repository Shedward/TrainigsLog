//
//  ExercisesList.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct ExercisesList: View {

    @Query(sort: \Exercise.name, animation: .default)
    var exercises: [Exercise] = []

    @State var openCreateExerciseSheet: Bool = false
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List(exercises) { exercise in
                ExerciseCell(exercise: exercise)
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                modelContext.delete(exercise)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(systemIcon: "plus") {
                        openCreateExerciseSheet = true
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .animation(.default, value: exercises)
        }
        .sheet(isPresented: $openCreateExerciseSheet) {
            CreateExercise()
                .presentationDetents([.medium])
        }
    }
}
