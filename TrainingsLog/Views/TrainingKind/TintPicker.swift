//
//  TintPicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftUI

struct TintPicker: View {

    @Binding var selected: Tint

    var body: some View {
        HStack {
            ForEach(Tint.allCases, id: \.self) { tint in
                Button {
                    self.selected = tint
                } label: {
                    TintCell(tint: tint)
                        .overlay {
                            if tint == selected {
                                Image(systemName: "checkmark")
                                    .font(.body.bold())
                                    .foregroundStyle(.white)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    TintPicker(selected: .constant(.red))
}
