//
//  ContentView.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct MuscleGroupList: View {

    @Query(sort: \MuscleGroup.name, animation: .default)
    var muscleGroups: [MuscleGroup] = []

    @State var openCreateMuscleGroupSheet: Bool = false
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List(muscleGroups) { muscleGroup in
                MuscleGroupCell(muscleGroup: muscleGroup)
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                modelContext.delete(muscleGroup)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")

                        }
                    }
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(systemIcon: "plus") {
                        openCreateMuscleGroupSheet = true
                    }
                    .keyboardShortcut("N", modifiers: .command)
                }
            }
            .animation(.default, value: muscleGroups)
        }
        .sheet(isPresented: $openCreateMuscleGroupSheet) {
            CreateMuscleGroup()
                .presentationDetents([.medium])
        }
    }
}
