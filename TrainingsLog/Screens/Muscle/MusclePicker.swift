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
