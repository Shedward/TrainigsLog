//
//  TrainingSessionCell.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 28.06.2025.
//

import SwiftUI

struct TrainingSessionCell: View {
    let trainingSession: TrainingSession

    var glyph: Glyph {
        trainingSession.kind?.glyph ?? .default
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                GlyphImage(glyph: glyph)
                VStack(alignment: .leading) {
                    Text(trainingSession.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption.smallCaps())
                    Text(trainingSession.kind?.name ?? String(localized: "-"))
                        .font(.title2.bold())
                        .foregroundStyle(glyph.tint.color)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(trainingSession.difficulty.displayValue)
                        .font(.caption.smallCaps())
                    Text(trainingSession.totalLoad.value.formatted())
                        .font(.title2.bold())
                        .foregroundStyle(glyph.tint.color)
                }
            }
            .padding(.horizontal)

            let exercises = trainingSession.data().exercises

            if !exercises.isEmpty {
                Divider()

                ScrollView(.horizontal) {
                    Grid(alignment: .leading) {
                        ForEach(exercises.blocks) { block in
                            GridRow {
                                Text(block.exercise?.name ?? String(localized: "-"))
                                    .font(.caption.smallCaps())

                                ForEach(block.sets) { set in
                                    Text(set.load.formatted(.workingLoad))
                                        .font(.caption2.bold())
                                        .gridColumnAlignment(.trailing)
                                    Text(set.load.formatted(.multiplier))
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .padding(.top, 4)
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.vertical)
        .background(.background.secondary)
        .cornerRadius(24)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    TrainingSessionCell(trainingSession: .mock1)
        .padding()
}
