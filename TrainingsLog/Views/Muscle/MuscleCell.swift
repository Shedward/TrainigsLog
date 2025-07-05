//
//  MuscleCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.06.2025.
//

import SwiftUI

struct MuscleCell: View {
    let muscle: Muscle

    var body: some View {
        VStack(alignment: .leading) {
            Text(muscle.name)
                .font(.body.bold())

            if let category = muscle.category {
                Text(category)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(minHeight: 32)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

#Preview {
    MuscleCell(muscle: Muscle(name: "Something"))
}
