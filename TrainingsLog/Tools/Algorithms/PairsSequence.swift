//
//  Untitled.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//

struct PairsSequence<Base: Sequence>: Sequence {
    let base: Base

    func makeIterator() -> AnyIterator<(Base.Element, Base.Element)> {
        var iterator = base.makeIterator()
        guard var previous = iterator.next() else {
            return AnyIterator { nil }
        }

        return AnyIterator {
            guard let current = iterator.next() else {
                return nil
            }
            defer { previous = current }
            return (previous, current)
        }
    }
}

extension Sequence {
    func pairs() -> PairsSequence<Self> {
        PairsSequence(base: self)
    }
}
