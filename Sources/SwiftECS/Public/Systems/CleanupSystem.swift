//
//  CleanupSystem.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 03.11.2019.
//

public final class CleanupSystem<C: Component>: SparseSetBackedSystem
{
    override public var traits: EntityTraitSet { EntityTraitSet(required: [C.self]) }

    override public func update() {
        entityIds.forEach { nexus.remove(C.self, from: $0) }
    }
}
