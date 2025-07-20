//
//  TrainingSession+Mock.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

import Foundation

extension TrainingSession {
    static let mock1 = TrainingSession(
        date: Date(),
        kind: TrainingKind(name: "Пречи / Руки", glyph: .default),
        trainings: [
            Training(exercise: .mock1, load: .weights(.init(weight: 2, reps: 20))),
            Training(exercise: .mock1, load: .weights(.init(weight: 6, reps: 12))),
            Training(exercise: .mock1, load: .weights(.init(weight: 6, reps: 12))),
            Training(exercise: .mock1, load: .weights(.init(weight: 6, reps: 12))),

            Training(exercise: .mock2, load: .weights(.init(weight: 45, reps: 12))),
            Training(exercise: .mock2, load: .weights(.init(weight: 50, reps: 12))),
            Training(exercise: .mock2, load: .weights(.init(weight: 50, reps: 12))),
            Training(exercise: .mock2, load: .weights(.init(weight: 50, reps: 12))),

            Training(exercise: .mock3, load: .weights(.init(weight: 27, reps: 12))),
            Training(exercise: .mock3, load: .weights(.init(weight: 32, reps: 12))),
            Training(exercise: .mock3, load: .weights(.init(weight: 32, reps: 12))),
            Training(exercise: .mock3, load: .weights(.init(weight: 32, reps: 12))),

            Training(exercise: .mock4, load: .weights(.init(weight: 27, reps: 12))),
            Training(exercise: .mock4, load: .weights(.init(weight: 27, reps: 12))),
            Training(exercise: .mock4, load: .weights(.init(weight: 27, reps: 12))),

            Training(exercise: .mock5, load: .weights(.init(weight: 14, reps: 12))),
            Training(exercise: .mock5, load: .weights(.init(weight: 18, reps: 12))),
            Training(exercise: .mock5, load: .weights(.init(weight: 18, reps: 10))),

            Training(exercise: .mock6, load: .repetitions(.init(count: 12, loadPerRep: 22))),
            Training(exercise: .mock6, load: .repetitions(.init(count: 18, loadPerRep: 22))),
            Training(exercise: .mock6, load: .repetitions(.init(count: 18, loadPerRep: 22))),
        ],
        difficulty: .normal,
    )
}
