//
//  GlyphImage.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 11.07.2025.
//

import SwiftUI

struct GlyphImage: View {
    let glyph: Glyph

    var size: CGFloat = 64
    var cornerRadius: CGFloat = 24

    var body: some View {
        icon
            .frame(width: size, height: size)
            .tint(glyph.tint.color)
            .foregroundStyle(glyph.tint.color)
            .background(glyph.tint.color.opacity(0.2))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius), style: .continuous))
            .font(.system(size: size * 0.4, weight: .bold))
    }

    @ViewBuilder
    var icon: some View {
        switch glyph.icon {
        case .none:
            Color.clear
        case .systemImage(let name):
            Image(systemName: name)
        case .text(let text):
            Text(text)
        }
    }
}

#Preview {
    HStack {
        GlyphImage(
            glyph: .init(icon: .text("AB"), tint: .green)
        )
        GlyphImage(
            glyph: .init(icon: .systemImage("house"), tint: .purple)
        )
        GlyphImage(
            glyph: .init(icon: .text("🤓"), tint: .yellow)
        )
    }
}
