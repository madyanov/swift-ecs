//
//  ComponentIdentifier.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct ComponentIdentifier
{
    let objectIdentifier: ObjectIdentifier

    init<T>(_ type: T.Type) where T: Component {
        self.objectIdentifier = ObjectIdentifier(type)
    }
}

extension ComponentIdentifier: Hashable { }
