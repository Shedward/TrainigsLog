//
//  CreateMuscle.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct CreateMuscle: View {

    @State var name: String = ""
    @State var category: String? = ""

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            UniversalForm {
                TextField("Name", text: $name)
                TextField("Category", text: $category.unwrappedOr(""))
            }
            .toolbar {
                Spacer()
                Button.cancel {
                    dismiss()
                }
                Button.save {
                    let muscle = Muscle(name: name, category: category?.nonWhitespace)
                    modelContext.insert(muscle)
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(name.isEmpty)
            }
        }
    }
}
