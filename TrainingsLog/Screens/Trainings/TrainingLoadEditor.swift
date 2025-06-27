//
//  TrainingLoadField.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import SwiftUI

struct TrainingLoadEditor: View {
    @Binding var trainingLoad: TrainingLoad

    @State private var selectedKind: Kind = .raw

    init(trainingLoad: Binding<TrainingLoad>) {
        self._trainingLoad = trainingLoad
        selectedKind = Kind(trainingLoad.wrappedValue)
    }

    var body: some View {
        Picker("Type", selection: $selectedKind) {
            ForEach(Kind.allCases, id: \.self) { kind in
                Text(kind.displayName).tag(kind)
            }
        }
        .onChange(of: trainingLoad) { _, newValue in
            selectedKind = Kind(trainingLoad)
        }
    }
}

extension TrainingLoadEditor {
    enum Kind: CaseIterable {
        case raw
        case weight
        case negativeWeight
        case distance
        case repetitions

        init(_ load: TrainingLoad) {
            switch load {
            case .raw:
                self = .raw
            case .weights:
                self = .weight
            case .negativeWeight:
                self = .negativeWeight
            case .distance:
                self = .distance
            case .repetitions:
                self = .repetitions
            }
        }

        var displayName: LocalizedStringKey {
            switch self {
            case .raw:
                "Raw"
            case .weight:
                "Weight"
            case .negativeWeight:
                "Negative weight"
            case .distance:
                "Distance"
            case .repetitions:
                "Repetitions"
            }
        }

        var defaultLoad: TrainingLoad {
            switch self {
            case .raw:
                TrainingLoad.raw(.init(value: .zero))
            case .weight:
                TrainingLoad.weights(.init(weight: .zero, reps: 0))
            case .negativeWeight:
                TrainingLoad.negativeWeight(
                    .init(bodyWeight: .zero, negativeWeight: .zero, reps: 0)
                )
            case .distance:
                TrainingLoad.distance(.init(distance: .zero, loadPerMeter: 0))
            case .repetitions:
                TrainingLoad.repetitions(.init(count: 0, loadPerRep: 0))
            }
        }
    }
}
