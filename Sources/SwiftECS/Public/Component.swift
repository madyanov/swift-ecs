//
//  Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public protocol Component: AnyObject, CustomStringConvertible
{
    var id: ComponentIdentifier { get }

    static var id: ComponentIdentifier { get }
}

public extension Component
{
    var id: ComponentIdentifier { Self.id }
    var description: String { String(describing: type(of: self)) }

    static var id: ComponentIdentifier { ComponentIdentifier(Self.self) }
}
