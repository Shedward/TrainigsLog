//
//  List+Multiplatform.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 04.07.2025.
//

import SwiftUI

extension View {
    func listRowInsetsMultiplatform(_ insets: EdgeInsets) -> some View {
        if #available(iOS 26.0, *) {
            return self.listRowInsets(insets)
        } else {
            return self
        }
    }
}
