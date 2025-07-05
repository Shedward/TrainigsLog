//
//  ModelSelector.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 05.07.2025.
//

import SwiftData
import SwiftUI

struct ModelSelector<T: PersistentModel, RowContent: View, CreateScreen: View>: View {

    let name: LocalizedStringKey
    let field: KeyPath<T, String>
    @Binding var selection: T?
    let rowContent: (T) -> RowContent
    let createScreen: () -> CreateScreen
    let onSelect: ((T) -> Void)?

    @State private var searchText: String = ""
    @State private var openCreateScreen: Bool = false
    @Query(animation: .default) private var allItems: [T]

    @Environment(\.dismiss)
    var dismiss

    var filteredItems: [T] {
        if searchText.isEmpty {
            return allItems
        } else {
            return allItems.filter { $0[keyPath: field].localizedCaseInsensitiveContains(searchText) }
        }
    }

    init(
        name: LocalizedStringKey,
        field: KeyPath<T, String>,
        selection: Binding<T?>,
        rowContent: @escaping (T) -> RowContent,
        createScreen: @escaping () -> CreateScreen,
        onSelect: ((T) -> Void)? = nil
    ) {
        self.name = name
        self.field = field
        self._selection = selection
        self.rowContent = rowContent
        self.createScreen = createScreen
        self.onSelect = onSelect
    }

    var body: some View {
        BottomSheet(name) {
            List(filteredItems) { row in
                Cell {
                    rowContent(row)
                } onTap: {
                    selection = row
                    onSelect?(row)
                    dismiss()
                }
            }
            .animation(.default, value: allItems)
            .frame(minHeight: 300)
            .searchable(text: $searchText)
            .toolbar {
                if CreateScreen.self != EmptyView.self {
                    ToolbarItem {
                        Button.add {
                            openCreateScreen = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $openCreateScreen) {
            createScreen()
        }
    }
}

extension ModelSelector where CreateScreen == EmptyView {
    init(
        name: LocalizedStringKey,
        field: KeyPath<T, String>,
        selection: Binding<T?>,
        @ViewBuilder rowContent: @escaping (T) -> RowContent,
        onSelect: ((T) -> Void)? = nil
    ) {
        self.name = name
        self.field = field
        self._selection = selection
        self.rowContent = rowContent
        self.createScreen = { EmptyView() }
        self.onSelect = onSelect
    }
}
