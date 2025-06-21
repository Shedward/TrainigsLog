//
//  String+Helpers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 20.06.2025.
//

import Foundation

extension String {

    var nonWhitespace: String? {
        trimmingCharacters(in: .whitespacesAndNewlines).nonEmpty
    }

    var nonEmpty: String? {
        !isEmpty ? self : nil
    }
}
