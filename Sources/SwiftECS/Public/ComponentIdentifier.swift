//
//  ComponentIdentifier.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct ComponentIdentifier
{
    private let objectId: ObjectIdentifier

    init<T>(_ type: T.Type) where T: Component {
        self.objectId = ObjectIdentifier(type)
    }
}

extension ComponentIdentifier: Hashable { }
