//
//  MuscleSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI


struct MuscleSelector: View {
    @State private var selection: Muscle?
    let onSelect: (Muscle) -> Void

    init(onSelect: @escaping (Muscle) -> Void) {
        self.onSelect = onSelect
    }

    var body: some View {
        ModelSelector(
            name: "Muscle",
            field: \Muscle.name,
            selection: $selection
        ) { muscle in
            MuscleCell(muscle: muscle)
        } createScreen: {
            EditMuscle()
        } onSelect: { muscle in
            onSelect(muscle)
        }
    }
}
