//
//  AppError.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import Foundation

struct AppError: Error {
    let message: LocalizedStringResource

    init(_ message: LocalizedStringResource) {
        self.message = message
    }
}
