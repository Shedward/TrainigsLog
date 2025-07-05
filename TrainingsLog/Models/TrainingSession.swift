//
//  TrainingSession.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import Foundation
import SwiftData

@Model
class TrainingSession {
    var date: Date
    var kind: TrainingKind?
    var trainings: [Training]
    var difficulty: Difficulty
    var comment: String?

    var totalLoad: WeightValue {
        let value = trainings.map(\.load.totalLoad).reduce(0, +)
        return WeightValue(value: value)
    }

    var groupedTrainings: TrainingGroups {
        TrainingGroups(grouping: trainings)
    }

    init(
        date: Date = Date(),
        kind: TrainingKind? = nil,
        trainings: [Training] = [],
        difficulty: Difficulty = .normal,
        comment: String? = nil
    ) {
        self.date = date
        self.kind = kind
        self.trainings = trainings
        self.difficulty = difficulty
        self.comment = comment
    }

    func delete(in modelContext: ModelContext? = nil) throws {
        guard let modelContext = self.modelContext else {
            throw AppError("Model сontext not found")
        }

        modelContext.delete(self)
    }
}

struct TrainingGroups {
    var groups: [Group]

    struct Group: Identifiable {
        var id: PersistentIdentifier? {
            trainings.first?.id
        }

        var exercise: Exercise?
        var trainings: [Training]
    }

    var allTrainings: [Training] {
        groups.flatMap(\.trainings)
    }

    init(groups: [Group] = []) {
        self.groups = groups
    }

    init(grouping trainings: [Training]) {
        var groups: [Group] = []
        var currentGroup: Group?

        for training in trainings {
            let exercise = training.exercise

            if let group = currentGroup {
                if group.exercise?.id == exercise?.id, exercise != nil {
                    currentGroup?.trainings.append(training)
                } else {
                    if let committedGroup = currentGroup {
                        groups.append(committedGroup)
                    }
                    currentGroup = Group(exercise: exercise, trainings: [training])
                }
            } else {
                currentGroup = Group(exercise: exercise, trainings: [training])
            }
        }

        if let committedGroup = currentGroup {
            groups.append(committedGroup)
        }

        self.groups = groups
    }

    mutating func newGroup(_ training: Training) {
        let newGroup = Group(exercise: training.exercise, trainings: [training])
        groups.append(newGroup)
    }

    mutating func addTraining(_ training: Training, to group: Group) {
        guard let index = groups.firstIndex(where: { $0.id == group.id }) else {
            return
        }

        groups[index].trainings.append(training)
    }

    mutating func deleteTraining(_ training: Training, from group: Group) {
        guard let index = groups.firstIndex(where: { $0.id == group.id }) else {
            return
        }

        groups[index].trainings.removeAll { $0.id == training.id }
    }

    mutating func deleteGroup(_ group: Group) {
        groups.removeAll { $0.id == group.id }
    }
}
