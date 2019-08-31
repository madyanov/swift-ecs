//
//  Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public protocol Component: AnyObject
{
    var id: ComponentIdentifier { get }
    static var id: ComponentIdentifier { get }
}

public extension Component
{
    var id: ComponentIdentifier {
        return Self.id
    }

    static var id: ComponentIdentifier {
        return ComponentIdentifier(Self.self)
    }
}
