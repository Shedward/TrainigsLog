//
//  TextList.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 29.06.2025.
//

import SwiftUI

struct TextList: View {

    let items: [String]

    private let description: String

    init(items: [String]) {
        self.items = items
        self.description = items.joined(separator: ", ")
    }

    var body: some View {
        Text(description)
    }
}
