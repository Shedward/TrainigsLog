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

    func split(by toFirst: (Element) -> Bool) -> ([Element], [Element]) {
        var before: [Element] = []
        var after: [Element] = []
        
        for element in self {
            if toFirst(element) {
                before.append(element)
            } else {
                after.append(element)
            }
        }

        return (before, after)
    }

    func uniqueArray() -> Array<Element> where Element: Hashable {
        Array(Set(self))
    }
}
