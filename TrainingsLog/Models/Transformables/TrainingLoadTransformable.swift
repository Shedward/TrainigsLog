//
//  JSONTransformable.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 26.06.2025.
//

import Foundation

import Foundation

@objc(TrainingLoadTransformable)
final class TrainingLoadTransformable: ValueTransformer {

    static func register() {
        ValueTransformer.setValueTransformer(TrainingLoadTransformable(), forName: NSValueTransformerName("TrainingLoadTransformable"))
    }

    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }

    override class func allowsReverseTransformation() -> Bool {
        true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let codableValue = value as? TrainingLoad else { return nil }
        return try? JSONEncoder().encode(codableValue)
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? JSONDecoder().decode(TrainingLoad.self, from: data)
    }
}
