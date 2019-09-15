//
//  Nexus+System.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 15/09/2019.
//

extension Nexus
{
    func updateSystemsMembership(of entityId: EntityIdentifier) {
        let components = componentIdsByEntityId[entityId] ?? []

        systems.forEach { system in
            if system.traits.match(components) {
                system.add(entityId)
            } else {
                system.remove(entityId)
            }
        }
    }
}