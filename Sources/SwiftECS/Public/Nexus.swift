//
//  Nexus.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public final class Nexus
{
    let entityIdsPool = EntityIdentifiersPool()
    var entityIds = UnorderedSparseSet<EntityIdentifier>()
    var componentsByComponentIds: [ComponentIdentifier: UnorderedSparseSet<Component>] = [:]
    var componentIdsByEntityId: [EntityIdentifier: Set<ComponentIdentifier>] = [:]

    let systems: [System]

    public init(systems: [System]) {
        self.systems = systems

        systems.forEach { $0.nexus = self }
    }
}
