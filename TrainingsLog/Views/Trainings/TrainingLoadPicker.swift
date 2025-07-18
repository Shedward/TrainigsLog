//
//  TrainingLoadField.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 27.06.2025.
//

import SwiftUI

struct TrainingLoadPicker: View {
    @Binding var trainingLoad: TrainingLoad

    @State private var selectedKind: TrainingLoad.Kind = .raw

    init(trainingLoad: Binding<TrainingLoad>) {
        self._trainingLoad = trainingLoad
        self._selectedKind = .init(initialValue: TrainingLoad.Kind(trainingLoad.wrappedValue))
    }

    var body: some View {
        Section("Load") {
            Picker("Type", selection: $selectedKind) {
                ForEach(TrainingLoad.Kind.allCases, id: \.self) { kind in
                    Text(kind.displayName).tag(kind)
                }
            }

            switch selectedKind {
            case .raw:
                RawFields($trainingLoad)
            case .weight:
                WeightFields($trainingLoad)
            case .addingWeight:
                AddingWeightFields($trainingLoad)
            case .negativeWeight:
                NegativeWeightFields($trainingLoad)
            case .distance:
                DistanceFields($trainingLoad)
            case .repetitions:
                RepetitionsFields($trainingLoad)
            }
        }
        .onChange(of: trainingLoad) { _, newValue in
            selectedKind = TrainingLoad.Kind(trainingLoad)
        }
    }
}

extension TrainingLoadPicker {

    struct RawFields: View {
        @Binding var raw: RawLoad?

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
        @Binding var weight: Weights?
        
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

    struct AddingWeightFields: View {
        @Binding var addingWeight: AddingWeights?

        init(_ load: Binding<TrainingLoad>) {
            self._addingWeight = load.transform {
                if case .addingWeights(let value) = $0 {
                    value
                } else {
                    nil
                }
            } to: {
                .addingWeights($0 ?? .zero)
            }
        }

        var body: some View {
            NumberField(label: "Initial Weight", unit: "kg", value: $addingWeight.unwrappedOr(.zero).initialWeight.value)
            NumberField(label: "Reps", unit: "reps", value: $addingWeight.unwrappedOr(.zero).reps)
            NumberField(label: "Weight", unit: "+kg", value: $addingWeight.unwrappedOr(.zero).weight.value)
        }
    }

    struct NegativeWeightFields: View {
        @Binding var negativeWeight: NegativeWeights?

        init(_ load: Binding<TrainingLoad>) {
            self._negativeWeight = load.transform {
                if case .negativeWeights(let value) = $0 {
                    value
                } else {
                    nil
                }
            } to: {
                .negativeWeights($0 ?? .zero)
            }
        }

        var body: some View {
            NumberField(label: "Body Weight", unit: "kg", value: $negativeWeight.unwrappedOr(.zero).bodyWeight.value)
            NumberField(label: "Reps", unit: "reps", value: $negativeWeight.unwrappedOr(.zero).reps)
            NumberField(label: "Negative Weight", unit: "-kg", value: $negativeWeight.unwrappedOr(.zero).negativeWeight.value)
        }
    }

    struct DistanceFields: View {
        @Binding var distance: Distance?
        
        init(_ load: Binding<TrainingLoad>) {
            self._distance = load.transform {
                if case .distance(let value) = $0 {
                    value
                } else {
                    nil
                }
            } to: {
                .distance($0 ?? .zero)
            }
        }

        var body: some View {
            NumberField(label: "Load Per Distance", unit: "kg/m", value: $distance.unwrappedOr(.zero).loadPerMeter)
            NumberField(label: "Distance", unit: "m", value: $distance.unwrappedOr(.zero).distance.value)
        }
    }

    struct RepetitionsFields: View {
        @Binding var repetitions: Repetitions?
        
        init(_ load: Binding<TrainingLoad>) {
            self._repetitions = load.transform {
                if case .repetitions(let value) = $0 {
                    value
                } else {
                    nil
                }
            } to: {
                .repetitions($0 ?? .zero)
            }
        }

        var body: some View {
            NumberField(label: "Load Per Repetition", unit: "kg/rep", value: $repetitions.unwrappedOr(.zero).loadPerRep)
            NumberField(label: "Repetitions", unit: "reps", value: $repetitions.unwrappedOr(.zero).count)
        }
    }
}
