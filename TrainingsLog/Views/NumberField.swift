//
//  NumberField.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 24.06.2025.
//

import SwiftUI

struct NumberField: View {
    let label: LocalizedStringKey

    @Binding var value: Double
    @State private var text: String
    @FocusState private var isFocused: Bool

    private static let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = .current
        f.numberStyle = .decimal
        f.maximumFractionDigits = 4
        return f
    }()

    init(label: LocalizedStringKey, value: Binding<Double>) {
        self.label = label
        self._value = value
        self._text = State(initialValue: String(value.wrappedValue))
    }

    var body: some View {
        TextField(label, text: $text)
        #if os(iOS)
            .keyboardType(.decimalPad)
        #endif
            .focused($isFocused)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if isFocused {
                        Spacer()
                        Button.done {
                            isFocused = false
                            if let number = Self.formatter.number(from: text) {
                                value = number.doubleValue
                            }
                        }
                    }
                }
            }
            .onSubmit {
                if let number = Self.formatter.number(from: text) {
                    value = number.doubleValue
                }
            }
            .onChange(of: value) { _, newValue in
                let newText = Self.formatter.string(from: NSNumber(value: newValue)) ?? ""
                if text != newText {
                    text = newText
                }
            }
    }
}
