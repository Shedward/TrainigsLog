//
//  TrainingLoadField.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import SwiftUI

struct TrainingLoadPicker: View {
    @Binding var trainingLoad: TrainingLoad

    @State private var selectedKind: Kind = .raw

    init(trainingLoad: Binding<TrainingLoad>) {
        self._trainingLoad = trainingLoad
        selectedKind = Kind(trainingLoad.wrappedValue)
    }

    var body: some View {
        Section("Load") {
            Picker("Type", selection: $selectedKind) {
                ForEach(Kind.allCases, id: \.self) { kind in
                    Text(kind.displayName).tag(kind)
                }
            }

            switch selectedKind {
            case .raw:
                RawFields($trainingLoad)
            case .weight:
                WeightFields($trainingLoad)
            case .negativeWeight:
                EmptyView()
            case .distance:
                EmptyView()
            case .repetitions:
                EmptyView()
            }
        }
        .onChange(of: trainingLoad) { _, newValue in
            selectedKind = Kind(trainingLoad)
        }
    }
}

extension TrainingLoadPicker {
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
                TrainingLoad.raw(.zero)
            case .weight:
                TrainingLoad.weights(.zero)
            case .negativeWeight:
                TrainingLoad.negativeWeight(.zero)
            case .distance:
                TrainingLoad.distance(.zero)
            case .repetitions:
                TrainingLoad.repetitions(.zero)
            }
        }
    }

    struct RawFields: View {
        @Binding var raw: TrainingLoad.Raw?

        init(_ load: Binding<TrainingLoad>) {
            self._raw = load.transform {
                if case .raw(let value) = $0 {
                    value
                } else {
                    nil
                }
            } to: {
                .raw($0 ?? .zero)
            }
        }

        var body: some View {
            NumberField(label: "Load", unit: "kg", value: $raw.unwrappedOr(.zero).value.value)
        }
    }

    struct WeightFields: View {
        @Binding var weight: TrainingLoad.Weights?
        
        init(_ load: Binding<TrainingLoad>) {
            self._weight = load.transform {
                if case .weights(let value) = $0 {
                    value
                } else {
                    nil
                }
            } to: {
                .weights($0 ?? .zero)
            }
        }

        var body: some View {
            NumberField(label: "Repetitions", unit: "reps", value: $weight.unwrappedOr(.zero).reps)
            NumberField(label: "Weight", unit: "kg", value: $weight.unwrappedOr(.zero).weight.value)
        }
    }
}
