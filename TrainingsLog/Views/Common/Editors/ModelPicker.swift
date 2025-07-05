//
//  ModelPicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftData
import SwiftUI

struct ModelPicker<T: PersistentModel, RowContent: View, CreateScreen: View>: View {

    let name: LocalizedStringKey
    let field: KeyPath<T, String>
    @Binding var selection: T?
    let rowContent: (T) -> RowContent
    let createScreen: () -> CreateScreen

    init(
        name: LocalizedStringKey,
        field: KeyPath<T, String>,
        selection: Binding<T?>,
        @ViewBuilder rowContent: @escaping (T) -> RowContent,
        @ViewBuilder createScreen: @escaping () -> CreateScreen,
    ) {
        self.name = name
        self.field = field
        self._selection = selection
        self.rowContent = rowContent
        self.createScreen = createScreen
    }

    @State private var openPicker: Bool = false

    var body: some View {
        LabeledContent(name) {
            let selected = selection.map { $0[keyPath: field] } ?? String(localized: "")
            #if os(macOS)
            Button {
                openPicker = true
            } label: {
                HStack {
                    Text(selected)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 3.5)
                        .padding(.vertical, 2)
                        .background(Color.blue)
                        .cornerRadius(4)
                        .offset(x: 6)
                }
            }
            #else
            Cell {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Spacer()
                    Text(selected)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(.secondary)
            } onTap: {
                openPicker = true
            }
            #endif
        }
        .sheet(isPresented: $openPicker) {
            ModelSelector(
                name: name,
                field: field,
                selection: $selection,
                rowContent: rowContent,
                createScreen: createScreen
            )
        }
    }
}

extension ModelPicker where CreateScreen == EmptyView {
    init(
        name: LocalizedStringKey,
        field: KeyPath<T, String>,
        selection: Binding<T?>,
        @ViewBuilder rowContent: @escaping (T) -> RowContent
    ) {
        self.name = name
        self.field = field
        self._selection = selection
        self.rowContent = rowContent
        self.createScreen = { EmptyView() }
    }
}
