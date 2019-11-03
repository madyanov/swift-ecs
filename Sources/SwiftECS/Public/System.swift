//
//  System.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 31/08/2019.
//

public protocol System: AnyObject
{
    var traits: EntityTraitSet { get }

    func has(_ entityId: EntityIdentifier) -> Bool
    func add(_ entityId: EntityIdentifier)
    func remove(_ entityId: EntityIdentifier)

    func update()
}
