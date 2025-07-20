//
//  Collection+Pairs.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

extension Sequence {
    func maxCount() -> Element? where Element: Hashable {
        var counts: [Element: Int] = [:]
        var maxElement: Element?
        var maxCount = 0

        for element in self {
            let count = (counts[element] ?? 0) + 1
            counts[element] = count
            if count > maxCount {
                maxCount = count
                maxElement = element
            }
        }

        return maxElement
    }
}
