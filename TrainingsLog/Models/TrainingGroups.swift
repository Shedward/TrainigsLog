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
final class TrainingGroups {
    var groups: [Group]

    struct Group: Identifiable {
        var id: PersistentIdentifier? {
            trainings.first?.id
        }

        var exercise: Exercise?
        var trainings: [Training]
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

    func newGroup(_ training: Training) {
        let newGroup = Group(exercise: training.exercise, trainings: [training])
        groups.append(newGroup)
    }

    func addTraining(_ training: Training, to group: Group) {
        guard let index = groups.firstIndex(where: { $0.id == group.id }) else {
            return
        }

        groups[index].trainings.append(training)
    }

    func deleteTraining(_ training: Training, from group: Group) {
        guard let index = groups.firstIndex(where: { $0.id == group.id }) else {
            return
        }

        groups[index].trainings.removeAll { $0.id == training.id }
    }

    func deleteGroup(_ group: Group) {
        groups.removeAll { $0.id == group.id }
    }
}

extension TrainingGroups {
    static var `default`: Self {
        .init()
    }
}
