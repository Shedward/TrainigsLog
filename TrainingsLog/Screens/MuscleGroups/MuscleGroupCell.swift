//
//  MuscleGroupCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.06.2025.
//

import SwiftUI

struct MuscleGroupCell: View {
    let muscleGroup: MuscleGroup

    var body: some View {
        VStack(alignment: .leading) {
            Text(muscleGroup.name)
                .font(.body.bold())

            if let category = muscleGroup.category {
                Text(category)
            }
        }
        .frame(minHeight: 32)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

#Preview {
    MuscleGroupCell(muscleGroup: MuscleGroup(name: "Something"))
}
