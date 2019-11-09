//
//  Nexus.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public final class Nexus
{
    let entityIdsPool = EntityIdentifiersPool()
    let entityIds = SparseSet<EntityIdentifier>()
    var componentsByComponentId: [ComponentIdentifier: SparseSet<Component>] = [:]
    var componentIdsByEntityId: [EntityIdentifier: Set<ComponentIdentifier>] = [:]
    var systems: [(system: System, traits: EntityTraitSet)] = []

    public init(systems: [System] = []) {
        addSystems(systems)
    }
}
