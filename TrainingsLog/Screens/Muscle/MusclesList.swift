//
//  ContentView.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct MusclesList: View {

    @Query(sort: \Muscle.name, animation: .default)
    var muscles: [Muscle] = []

    @Environment(\.modelContext) private var modelContext
    @Environment(ErrorHandler.self) private var errorHandler
    @State private var openEditMuscleSheet: Muscle?

    var body: some View {
        NavigationStack {
            List(muscles) { muscle in
                Cell {
                    MuscleCell(muscle: muscle)
                } onTap: {

                }
                .swipeActions {
                    Button.delete {
                        withAnimation {
                            errorHandler.try {
                                try muscle.delete()
                            }
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button.add {
                        openEditMuscleSheet = Muscle()
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .animation(.default, value: muscles)
        }
        .sheet(item: $openEditMuscleSheet) { muscle in
            EditMuscle(muscle: muscle)
        }
    }
}
