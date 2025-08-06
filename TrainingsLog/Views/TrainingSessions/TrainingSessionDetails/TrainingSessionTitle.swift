//
//  TrainingKindTitle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

import SwiftUI

struct TrainingSessionTitle: View {
    let trainingSession: TrainingSession

    var body: some View {
        HStack {
            if let glyph = trainingSession.kind?.glyph {
                GlyphImage(glyph: glyph, size: 32, cornerRadius: 12)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(trainingSession.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2.smallCaps())

                if let kind = trainingSession.kind {
                    Text(kind.name)
                        .font(.body.bold())
                        .foregroundStyle(kind.glyph?.tint.color ?? .primary)
                }
            }
        }
    }
}
