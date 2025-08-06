//
//  TrainingLoadByMuscle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 06.08.2025.
//

struct TrainingLoadByMuscle {
    struct LoadByMuscle: Identifiable {
        var id: AnyHashable {
            muscle.id
        }

        let muscle: Muscle
        let load: WeightValue
    }

    let loadByMuscle: [LoadByMuscle]

    var isEmpty: Bool {
        loadByMuscle.isEmpty
    }

    init(loadByMuscle: [LoadByMuscle]) {
        self.loadByMuscle = loadByMuscle
    }

    init(trainingSession: TrainingSession) {
        self.init(trainings: trainingSession.trainings)
    }

    init(trainings: [Training]) {
        var loadByMuscle: [Muscle: WeightValue] = [:]

        for training in trainings {
            if let exercise = training.exercise {
                for muscleLoad in exercise.muscleLoads {
                    if let muscle = muscleLoad.muscle {
                        loadByMuscle[muscle, default: .zero].value += muscleLoad.loadFraction * training.load.totalLoad
                    }
                }
            }
        }

        self.loadByMuscle = loadByMuscle
            .sorted { $0.key.name < $1.key.name }
            .map { LoadByMuscle(muscle: $0.key, load: $0.value) }
    }
}
