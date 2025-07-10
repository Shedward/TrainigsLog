//
//  Binding+Helpers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI

extension Binding {
    func unwrappedOr<T>(_ defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T> {
            self.wrappedValue ?? defaultValue
        } set: { new in
            self.wrappedValue = new
        }
    }

    func transform<T>(from: @escaping (Value) -> T, to: @escaping (T) -> Value) -> Binding<T> {
        Binding<T> {
            from(self.wrappedValue)
        } set: { new in
            self.wrappedValue = to(new)
        }
    }
}
