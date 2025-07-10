//
//  Button+Helpers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.06.2025.
//

import SwiftUI

extension Button where Label == Image {
    init(
        systemIcon: String,
        action: @escaping () -> Void,
    ) {
        self.init(action: action) {
            Image(systemName: systemIcon)
        }
    }
}
