//
//  TrainingSessionKindCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI

struct TrainingKindCell: View {
    var kind: TrainingKind
    
    var body: some View {
        HStack {
            Text(kind.name)
            if let tint = kind.tint {
                Spacer()
                TintCell(tint: tint)
            }
        }
    }
}

#Preview {
    TrainingKindCell(kind: TrainingKind(name: "Name", tint: .red))
}
