//
//  GlyphPicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 11.07.2025.
//

import SwiftUI

struct GlyphPicker: View {
    @Binding var selection: Glyph?
    @Binding var openEditor: Bool
    
    var body: some View {
        Cell {
            HStack {
                Text("Glyph")
                Spacer()
                GlyphImage(
                    glyph: selection ?? .default,
                    size: 42,
                    cornerRadius: 16
                )
            }
        } onTap: {
            self.openEditor = true
        }
        .sheet(isPresented: $openEditor) {
            GlyphSelector(selected: selection ?? .default) { glyph in
                selection = glyph
            }
        }
    }
}
