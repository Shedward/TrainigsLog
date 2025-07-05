//
//  Untitled.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI
import SwiftData

struct EditTrainingKind: View {

    @Bindable var kind: TrainingKind

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    init(kind: TrainingKind = .init()) {
        self._kind = .init(wrappedValue: kind)
    }

    var body: some View {
        BottomSheet("Training Session Kind") {
            UniversalForm {
                TextField("Name", text: $kind.name)
                TintPicker(selected: $kind.tint.unwrappedOr(.none))
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        modelContext.insert(kind)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(kind.name.isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    EditTrainingKind(kind: TrainingKind(name: "Hello", tint: .red))
}
