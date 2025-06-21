//
//  IfPlatform.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftUI

extension View {
    @inlinable
    func ifMacOS<Content: View>(_ content: (Self) -> Content) -> some View {
#if os(macOS)
        content(self)
#else
        self
#endif
    }

    @inlinable
    func ifiOS<Content: View>(_ content: (Self) -> Content) -> some View {
#if os(iOS)
        content(self)
#else
        self
#endif
    }

    @inlinable
    func ifWatchOS<Content: View>(_ content: (Self) -> Content) -> some View {
#if os(watchOS)
        content(self)
#else
        self
#endif
    }
}
