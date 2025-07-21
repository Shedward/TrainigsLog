//
//  TrainingGroups.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 09.07.2025.
//

import Foundation
import SwiftData
import Observation

@Observable
final class TrainingSessionExercises {

    @Observable
    final class ExerciseBlock: Identifiable {
        let id: PersistentIdentifier
        var sets: [ExerciseSet]
        var exerciseStats: ExerciseLoadStats?

        var exercise: Exercise? {
            sets.first?.training.exercise
        }

        init(firstTraining: Training, exerciseStats: ExerciseLoadStats?) {
            self.id = firstTraining.id
            self.sets = []
            self.exerciseStats = exerciseStats

            self.sets = [.init(training: firstTraining, block: self)]
        }

        func repeatSet() {
            let lastLoad = sets.last?.load ?? .zero
            let training = Training(exercise: exercise, load: lastLoad)
            sets.append(.init(training: training, block: self))
        }

        func delete(training: Training) {
            sets.removeAll { $0.training.id == training.id }
        }

        func delete(set: ExerciseSet) {
            sets.removeAll { $0.id == set.id }
        }
    }

    @Observable
    final class ExerciseSet: Identifiable {
        let id: PersistentIdentifier
        let training: Training

        var load: TrainingLoad
        weak var block: ExerciseBlock?

        init(training: Training, block: ExerciseBlock?) {
            self.id = training.id
            self.training = training
            self.load = training.load
            self.block = block
        }
    }


    private(set) var blocks: [ExerciseBlock]

    var isEmpty: Bool {
        blocks.isEmpty
    }

    init(blocks: [ExerciseBlock] = []) {
        self.blocks = blocks
    }

    init(grouping trainings: [Training]) {
        var blocks: [ExerciseBlock] = []
        var currentBlock: ExerciseBlock?

        for training in trainings {
            if let block = currentBlock {
                if block.exercise == training.exercise {
                    block.sets.append(.init(training: training, block: block))
                } else {
                    blocks.append(block)
                    currentBlock = .init(firstTraining: training, exerciseStats: nil)
                }
            } else {
                currentBlock = .init(firstTraining: training, exerciseStats: nil)
            }
        }

        if let currentBlock {
            blocks.append(currentBlock)
        }
        
        self.blocks = blocks
    }

    func appendNewBlock(exercise: Exercise, exerciseStats: ExerciseLoadStats?) {
        let training = Training(exercise: exercise, load: exerciseStats?.lastSession.first ?? .zero)
        blocks.append(.init(firstTraining: training, exerciseStats: exerciseStats))
    }

    func delete(block: ExerciseBlock) {
        blocks.removeAll { block.id == $0.id }
    }

    func delete(training: Training) {
        blocks.forEach { block in
            block.delete(training: training)
        }
    }

    func delete(set: ExerciseSet) {
        blocks.forEach { block in
            block.delete(set: set)
        }
    }

}

extension TrainingSessionExercises {
    static var `default`: Self {
        .init()
    }
}
