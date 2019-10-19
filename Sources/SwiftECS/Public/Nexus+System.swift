//
//  Nexus+System.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 15/09/2019.
//

public extension Nexus
{
    func addSystem(_ system: System) {
        addSystems([system])
    }

    func addSystems(_ systems: [System]) {
        self.systems += systems
    }
}

extension Nexus
{
    func updateSystemsMembership(of entityId: EntityIdentifier) {
        let components = componentIdsByEntityId[entityId] ?? []

        systems.forEach { system in
            let has = system.has(entityId)
            let matches = system.traits.match(components)

            switch (has, matches) {
            case (false, true): system.add(entityId)
            case (true, false): system.remove(entityId)
            default: break
            }
        }
    }
}
