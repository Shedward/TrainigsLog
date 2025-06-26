//
//  ErrorHandlers.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import Foundation
import SwiftUI
import OSLog

@Observable
class ErrorHandler {
    let logger = Logger()

    func show(_ message: String) {
        logger.error("\(message)")
    }


    func `try`<Result>(_ handle: () throws -> Result) -> Result? {
        do {
            return try handle()
        } catch {
            show(error.localizedDescription)
        }

        return nil
    }
}
