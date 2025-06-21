//
//  CreateMuscleGroup.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 17.06.2025.
//

import SwiftUI
import SwiftData

struct CreateMuscleGroup: View {

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
                Button("Cancel") {
                    dismiss()
                }
                Button("Add") {
                    let muscleGroup = MuscleGroup(name: name, category: category?.nonWhitespace)
                    modelContext.insert(muscleGroup)
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(name.isEmpty)
            }
        }
    }
}
