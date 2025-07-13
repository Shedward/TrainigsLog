//
//  GlyphSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 12.07.2025.
//

import SwiftUI

struct GlyphSelector: View {
    private let onSelected: (Glyph) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var glyph: Glyph
    @State private var kind: Kind = .systemImage
    @State private var text: String = ""

    init(selected: Glyph = .default, onSelected: @escaping (Glyph) -> Void) {
        self.onSelected = onSelected
        self._glyph = .init(initialValue: selected)
    }

    var body: some View {
        BottomSheet("Glyph") {
            UniversalForm {
                GlyphImage(glyph: glyph)
                TintPicker(selected: $glyph.tint)
                Picker("Type", selection: $kind) {
                    ForEach(Kind.allCases, id: \.self) { kind in
                        Text(kind.rawValue).tag(kind)
                    }
                }
                if kind != .none {
                    TextField("Text", text: $text)
                }
            }
            .onChange(of: kind) { _, newValue in
                updateGlyph(kind: newValue, text: text)
            }
            .onChange(of: text) { _, newValue in
                updateGlyph(kind: kind, text: newValue)
            }
            .toolbar {
                Button.save {
                    onSelected(glyph)
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
    }

    private func updateGlyph(kind: Kind, text: String) {
        glyph.icon = switch kind {
        case .none:
            nil
        case .systemImage:
            .systemImage(text)
        case .text:
            .text(text)
        }
    }
}

extension GlyphSelector {
    enum Kind: LocalizedStringKey, CaseIterable, Equatable {
        case systemImage = "System Image"
        case text = "Text"
        case none = "None"
    }
}
