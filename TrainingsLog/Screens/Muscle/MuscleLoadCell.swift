//
//  MuscleLoadCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 24.06.2025.
//

import SwiftData
import SwiftUI

struct MuscleLoadCell: View {
    @Bindable var muscleLoad: MuscleLoad
    @Environment(\.modelContext) var modelContext

    var body: some View {
        HStack {
            if let muscle = muscleLoad.muscle {
                Text(muscle.name)
            }
            Spacer()
            NumberField(label: "", value: $muscleLoad.loadFraction)
                .textFieldStyle(.plain)
                .frame(minWidth: 64, alignment: .trailing)
                .fixedSize()
        }
        .frame(maxWidth: .infinity)
    }
}
