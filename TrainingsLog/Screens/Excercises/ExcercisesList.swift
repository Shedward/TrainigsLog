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
    @State var openEditExerciseSheet: Exercise?
    @Environment(\.modelContext) var modelContext
    @Environment(ErrorHandler.self) private var errorHandler

    var body: some View {
        NavigationStack {
            List(exercises) { exercise in
                Cell {
                    ExerciseCell(exercise: exercise)
                } onTap: {
                    openEditExerciseSheet = exercise
                }
                .swipeActions {
                    Button.delete {
                        withAnimation {
                            errorHandler.try {
                                try exercise.delete()
                            }
                        }
                    }
                }
                
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button.add {
                        openCreateExerciseSheet = true
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .animation(.default, value: exercises)
        }
        .sheet(isPresented: $openCreateExerciseSheet) {
            EditExercise()
        }
        .sheet(item: $openEditExerciseSheet) { exercise in
            EditExercise(exercise: exercise)
        }
    }
}
