//
//  PrefixWithSame.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 18.07.2025.
//


struct PrefixSameSequence<Base: Sequence, Value: Equatable>: Sequence {
    let base: Base
    let keyPath: KeyPath<Base.Element, Value>

    func makeIterator() -> AnyIterator<Base.Element> {
        var iterator = base.makeIterator()
        guard let first = iterator.next() else {
            return AnyIterator { nil }
        }

        let currentValue = first[keyPath: keyPath]
        var yieldedFirst = false

        return AnyIterator {
            if !yieldedFirst {
                yieldedFirst = true
                return first
            }
            guard let next = iterator.next() else { return nil }
            return next[keyPath: keyPath] == currentValue ? next : nil
        }
    }
}

extension Sequence {
    func prefixSame<Value: Equatable>(
        _ keyPath: KeyPath<Element, Value>
    ) -> PrefixSameSequence<Self, Value> {
        PrefixSameSequence(base: self, keyPath: keyPath)
    }
}
