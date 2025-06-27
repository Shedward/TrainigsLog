//
//  NumberField.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 24.06.2025.
//

import SwiftUI

struct NumberField<Value: NumberFieldValue>: View {
    let label: LocalizedStringKey
    let unit: LocalizedStringKey?

    @Binding var value: Value
    @State private var text: String

    init(label: LocalizedStringKey, unit: LocalizedStringKey? = nil, value: Binding<Value>) {
        self.label = label
        self._value = value
        self._text = State(initialValue: value.wrappedValue.toString())
        self.unit = unit
    }

    var body: some View {
        TextField(label, text: $text)
            .overlay(alignment: .trailing) {
                if let unit = unit {
                    Text(unit)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(.background, in: RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                }
            }
        #if os(iOS)
            .keyboardType(.decimalPad)
        #endif
            .onChange(of: text) { oldValue, newValue in
                let newValue = Value.from(string: text)
                if let newValue, newValue != value {
                    value = newValue
                }
            }
            .onChange(of: value) { _, newValue in
                let newText = value.toString()
                if text != newText {
                    text = newText
                }
            }
    }
}


protocol NumberFieldValue: Equatable {
    static func from(string: String) -> Self?
    func toString() -> String
}

private let numberFieldNumberFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.locale = .current
    f.numberStyle = .decimal
    f.usesGroupingSeparator = false
    f.usesSignificantDigits = true
    return f
}()


extension Double: NumberFieldValue {
    public static func from(string: String) -> Double? {
        return numberFieldNumberFormatter.number(from: string)?.doubleValue
    }
    
    public func toString() -> String {
        return numberFieldNumberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Int: NumberFieldValue {
    public static func from(string: String) -> Int? {
        return numberFieldNumberFormatter.number(from: string)?.intValue
    }
    
    public func toString() -> String {
        return numberFieldNumberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
