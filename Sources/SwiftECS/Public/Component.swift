//
//  Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public protocol Component: AnyObject
{
    var identifier: ComponentIdentifier { get }
    static var identifier: ComponentIdentifier { get }
}

public extension Component
{
    var identifier: ComponentIdentifier {
        return Self.identifier
    }

    static var identifier: ComponentIdentifier {
        return ComponentIdentifier(Self.self)
    }
}
