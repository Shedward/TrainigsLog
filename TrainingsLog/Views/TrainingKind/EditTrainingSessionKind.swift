//
//  Untitled.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI
import SwiftData

struct EditTrainingKind: View {

    private let kindModel: TrainingKind

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var kindData: TrainingKind.Data
    @State private var openKindEditor: Bool = false

    init(kind: TrainingKind = .init()) {
        self.kindModel = kind
        self._kindData = .init(initialValue: kind.data())
    }

    var body: some View {
        BottomSheet("Training Session Kind") {
            UniversalForm {
                TextField("Name", text: $kindData.name)
                GlyphPicker(selection: $kindData.glyph, openEditor: $openKindEditor)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button.save {
                        kindModel.save(data: kindData)
                        modelContext.insert(kindModel)
                        dismiss()
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(kindData.name.isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    EditTrainingKind(kind: TrainingKind(name: "Hello", glyph: .default))
}
