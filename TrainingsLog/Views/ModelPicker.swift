//
//  ModelPicker.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import SwiftData
import SwiftUI

struct ModelPicker<T: PersistentModel, RowContent: View>: View {

    let name: LocalizedStringKey
    let field: KeyPath<T, String>
    @Binding var selection: T?
    let rowContent: (T) -> RowContent

    @State private var openPicker: Bool = false

    var body: some View {
        Button {
            openPicker = true
        } label: {
            HStack {
                Text(name)
                Spacer()
                if let selection {
                    Text(selection[keyPath: field])
                        .foregroundStyle(.secondary)
                }
                Image(systemName: "chevron.down")
            }
        }
        .sheet(isPresented: $openPicker) {
            ModelPickerSelector(
                name: name,
                field: field,
                selection: $selection,
                rowContent: rowContent
            )
        }
    }
}


struct ModelPickerSelector<T: PersistentModel, RowContent: View>: View {

    let name: LocalizedStringKey
    let field: KeyPath<T, String>
    @Binding var selection: T?
    let rowContent: (T) -> RowContent

    @State private var searchText: String = ""
    @Query private var allItems: [T]

    @Environment(\.dismiss)
    var dismiss

    var filteredItems: [T] {
        if searchText.isEmpty {
            return allItems
        } else {
            return allItems.filter { $0[keyPath: field].localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List(allItems) { row in
                Button {
                    selection = row
                    dismiss()
                } label: {
                    rowContent(row)
                }
            }
            .frame(minHeight: 300)
            .searchable(text: $searchText)
            .navigationTitle(name)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
