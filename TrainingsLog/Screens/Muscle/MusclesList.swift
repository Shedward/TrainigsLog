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

    @State var openCreateMuscleSheet: Bool = false
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List(muscles) { muscle in
                MuscleCell(muscle: muscle)
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                modelContext.delete(muscle)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")

                        }
                    }
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(systemIcon: "plus") {
                        openCreateMuscleSheet = true
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .animation(.default, value: muscles)
        }
        .sheet(isPresented: $openCreateMuscleSheet) {
            CreateMuscle()
                .presentationDetents([.medium])
        }
    }
}
