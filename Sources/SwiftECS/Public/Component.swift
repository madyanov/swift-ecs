//
//  Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public protocol Component: AnyObject
{
    static var identifier: ComponentIdentifier { get }
}

public extension Component
{
    static var identifier: ComponentIdentifier {
        return ComponentIdentifier(Self.self)
    }
}
