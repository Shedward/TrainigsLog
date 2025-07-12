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

        var exercise: Exercise? {
            sets.first?.training.exercise
        }

        init(firstTraining: Training) {
            self.id = firstTraining.id
            self.sets = [.init(training: firstTraining)]
        }

        func repeatSet() {
            let lastLoad = sets.last?.load ?? .zero
            let training = Training(exercise: exercise, load: lastLoad)
            sets.append(.init(training: training))
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

        init(training: Training) {
            self.id = training.id
            self.training = training
            self.load = training.load
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
                    block.sets.append(.init(training: training))
                } else {
                    blocks.append(block)
                    currentBlock = .init(firstTraining: training)
                }
            } else {
                currentBlock = .init(firstTraining: training)
            }
        }

        if let currentBlock {
            blocks.append(currentBlock)
        }
        
        self.blocks = blocks
    }

    func appendNewBlock(exercise: Exercise) {
        let training = Training(exercise: exercise)
        blocks.append(.init(firstTraining: training))
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
