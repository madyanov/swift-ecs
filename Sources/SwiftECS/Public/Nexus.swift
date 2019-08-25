//
//  Nexus.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public final class Nexus
{
    let entityIDsPool = EntityIdentifiersPool()
    var componentsByComponentIDs: [ComponentIdentifier: UnorderedSparseSet<Component>] = [:]
    var componentIDsByEntityID: [EntityIdentifier: Set<ComponentIdentifier>] = [:]
    var entitiesByTraits: [ViewTraitSet: UnorderedSparseSet<Entity>] = [:]
}
