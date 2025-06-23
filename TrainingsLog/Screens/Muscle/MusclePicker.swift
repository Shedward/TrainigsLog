//
//  MusclePicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 21.06.2025.
//

import SwiftUI

struct MusclePicker: View {
    @Binding var selection: Muscle?

    var body: some View {
        ModelPicker(
            name: "Muscle",
            field: \Muscle.name,
            selection: $selection
        ) { muscle in
            MuscleCell(muscle: muscle)
        } createScreen: {
            CreateMuscle()
        }
    }
}

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
            CreateMuscle()
        } onSelect: { muscle in
            onSelect(muscle)
        }
    }
}
