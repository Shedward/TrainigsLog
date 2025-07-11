//
//  Debug.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 11.07.2025.
//

import SwiftUI
import OSLog

extension Binding {
    @available(*, deprecated, message: "Debug only")
    func debug(
        _ label: StaticString = #function,
        file: StaticString = #fileID,
        line: UInt = #line,
        get: Bool = false,
        set: Bool = true,
    ) -> Binding<Value> {
        debug(
            label,
            file: file,
            line: line,
            get: get,
            set: set,
            for: { $0 }
        )
    }

    @available(*, deprecated, message: "Debug only")
    func debug<T>(
        _ label: StaticString = #function,
        file: StaticString = #fileID,
        line: UInt = #line,
        get: Bool = false,
        set: Bool = true,
        for: (Value) -> T
    ) -> Binding<Value> {
        let logger = Logger()
        return .init(
            get: {
                if get {
                    logger.debug("\(file):\(line) \(label): get \(String(describing: wrappedValue))")
                }
                return wrappedValue
            },
            set: { newValue in
                if set {
                    logger.debug("\(file):\(line) \(label): set \(String(describing: newValue))")
                }
                wrappedValue = newValue
            }
        )
    }
}

extension View {
    @available(*, deprecated, message: "Debug only")
    func debugUpdates(id: UUID = UUID()) -> some View {
        let color = Color(
            red: .random(in: 0.2...1),
            green: .random(in: 0.2...1),
            blue: .random(in: 0.2...1),
            opacity: 0.4
        )
        return self
            .id(id)
            .background(color)
    }
}
