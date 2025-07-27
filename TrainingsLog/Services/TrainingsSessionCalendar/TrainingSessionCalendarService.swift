//
//  TrainingSessionCalendarService.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 22.07.2025.
//

import SwiftData
import Foundation

final class TrainingSessionCalendarService {
    let modelContext: ModelContext
    let calendar = Calendar.current

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func sessions(in interval: DateInterval) throws -> [TrainingSession] {
        let descriptor = FetchDescriptor<TrainingSession>(
            predicate: #Predicate {
                $0.date >= interval.start && $0.date <= interval.end
            },
            sortBy: [.init(\.date)]
        )

        return try modelContext.fetch(descriptor)
    }

    func weekSummary(for date: Date = Date()) throws -> TrainingSessionWeekSummary {
        guard
            let startOfCurrentWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start,
            let endOfCurrentWeek = calendar.date(byAdding: .day, value: 7, to: startOfCurrentWeek),
            let startOfPreviousWeek = calendar.date(byAdding: .day, value: -7, to: startOfCurrentWeek)
        else {
            throw AppError("Failed to get week intervals")
        }

        let allSessions = try sessions(in: DateInterval(start: startOfPreviousWeek, end: endOfCurrentWeek))

        let daysSummary = calendar.daysOfTheWeek(startDate: startOfCurrentWeek).map { dayInterval in
            let currentSessions = allSessions.filter { dayInterval.contains($0.date) }
            let previousSessions: [TrainingSession]

            if
                currentSessions.isEmpty,
                let dayWeekAgoStart = calendar.date(byAdding: .weekOfYear, value: -1, to: dayInterval.start),
                let dayWeekAgoEnd = calendar.date(byAdding: .day, value: 1, to: dayWeekAgoStart)
            {
                let dayWeekAgoInterval = DateInterval(start: dayWeekAgoStart, end: dayWeekAgoEnd)
                previousSessions = allSessions.filter { dayWeekAgoInterval.contains($0.date) }
            } else {
                let sessionsByKind =  Dictionary(grouping: currentSessions, by: \.kind)
                var previousSessionForGivenKinds: [TrainingSession] = []

                for kind in sessionsByKind.keys {
                    let currentSessionsIdsForKind = Set(sessionsByKind[kind]?.map(\.id) ?? [])
                    if
                        let previousSession = allSessions.reversed()
                            .first(where: { s in !currentSessionsIdsForKind.contains(s.id) && s.kind == kind })
                    {
                        previousSessionForGivenKinds.append(previousSession)
                    }
                }

                previousSessions = previousSessionForGivenKinds
            }

            let kinds = (currentSessions.map(\.kind) + previousSessions.map(\.kind))
                .compactMap { $0 }
                .uniqueArray()

            let previousLoad = previousSessions.map(\.totalLoad).reduce(.zero, +)
            let currentLoad = currentSessions.map(\.totalLoad).reduce(.zero, +)

            return TrainingSessionWeekSummary.DaySummary(
                interval: dayInterval,
                kinds: kinds,
                previousLoad: previousSessions.isEmpty ? nil : previousLoad,
                currentLoad: currentSessions.isEmpty ? nil : currentLoad
            )
        }

        return TrainingSessionWeekSummary(days: daysSummary)
    }

    func lastSessions(for kind: TrainingKind, maxCount: Int = 30) throws -> [TrainingSession] {
        let id = kind.id
        var descriptor = FetchDescriptor<TrainingSession>(
            predicate: #Predicate {
                $0.kind?.id == id
            },
            sortBy: [.init(\.date)]
        )

        descriptor.fetchLimit = maxCount

        return try modelContext.fetch(descriptor)
    }
}

extension ModelContext {
    var trainingCalendar: TrainingSessionCalendarService {
        TrainingSessionCalendarService(modelContext: self)
    }
}
