//
//  CleanupSystem.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 16.10.2019.
//

public final class CleanupSystem<C: Component>: SparseSetBakedSystem
{
    override public var traits: EntityTraitSet { EntityTraitSet(required: [C.self]) }

    public func removeComponent() {
        entityIds.forEach { nexus.remove(C.self, from: $0) }
    }

    public func removeEntities() {
        entityIds.forEach { nexus.removeEntity($0) }
    }
}
