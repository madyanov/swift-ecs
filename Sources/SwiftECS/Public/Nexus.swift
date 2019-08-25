//
//  Nexus.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public final class Nexus
{
    let entityIdsPool = EntityIdentifiersPool()
    var componentsByComponentIds: [ComponentIdentifier: UnorderedSparseSet<Component>] = [:]
    var componentIdsByEntityId: [EntityIdentifier: Set<ComponentIdentifier>] = [:]
    var entitiesByTraits: [ViewTraitSet: UnorderedSparseSet<Entity>] = [:]
}