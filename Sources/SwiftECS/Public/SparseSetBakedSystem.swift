//
//  SparseSetBakedSystem.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 13.10.2019.
//

open class SparseSetBakedSystem: System
{
    open var traits: EntityTraitSet { fatalError("not implemented") }

    public let entityIds = UnorderedSparseSet<EntityIdentifier>()

    public init() {}

    public func add(_ entityId: EntityIdentifier) { entityIds.insert(entityId) }
    public func remove(_ entityId: EntityIdentifier) { entityIds.remove(entityId) }
}
