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
    let ex1 = Exercise(name: "Махи гантелей")
    let ex2 = Exercise(name: "Тяга в/блока на плечи")
    let ex3 = Exercise(name: "Батерфляй")
    let ex4 = Exercise(name: "Канат на трицепс")
    let ex5 = Exercise(name: "Сгибание на бицепс")
    let ex6 = Exercise(name: "Поднятие ног со скруч.")

    let trainingSession = TrainingSession(
        date: Date(),
        kind: TrainingKind(name: "Пречи / Руки", glyph: .default),
        trainings: [
            Training(exercise: ex1, load: .weights(.init(weight: 2, reps: 20))),
            Training(exercise: ex1, load: .weights(.init(weight: 6, reps: 12))),
            Training(exercise: ex1, load: .weights(.init(weight: 6, reps: 12))),
            Training(exercise: ex1, load: .weights(.init(weight: 6, reps: 12))),

            Training(exercise: ex2, load: .weights(.init(weight: 45, reps: 12))),
            Training(exercise: ex2, load: .weights(.init(weight: 50, reps: 12))),
            Training(exercise: ex2, load: .weights(.init(weight: 50, reps: 12))),
            Training(exercise: ex2, load: .weights(.init(weight: 50, reps: 12))),

            Training(exercise: ex3, load: .weights(.init(weight: 27, reps: 12))),
            Training(exercise: ex3, load: .weights(.init(weight: 32, reps: 12))),
            Training(exercise: ex3, load: .weights(.init(weight: 32, reps: 12))),
            Training(exercise: ex3, load: .weights(.init(weight: 32, reps: 12))),

            Training(exercise: ex4, load: .weights(.init(weight: 27, reps: 12))),
            Training(exercise: ex4, load: .weights(.init(weight: 27, reps: 12))),
            Training(exercise: ex4, load: .weights(.init(weight: 27, reps: 12))),

            Training(exercise: ex5, load: .weights(.init(weight: 14, reps: 12))),
            Training(exercise: ex5, load: .weights(.init(weight: 18, reps: 12))),
            Training(exercise: ex5, load: .weights(.init(weight: 18, reps: 10))),

            Training(exercise: ex6, load: .repetitions(.init(count: 12, loadPerRep: 22))),
            Training(exercise: ex6, load: .repetitions(.init(count: 18, loadPerRep: 22))),
            Training(exercise: ex6, load: .repetitions(.init(count: 18, loadPerRep: 22))),
        ],
        difficulty: .normal,
    )
    TrainingSessionCell(trainingSession: trainingSession)
        .padding()
}
