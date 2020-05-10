//
//  Nexus+System.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 15/09/2019.
//

public extension Nexus
{
    convenience init(systems: [System] = []) {
        self.init()
        addSystems(systems)
    }

    func addSystem(_ system: System) {
        addSystems([system])
    }

    func addSystems(_ systems: [System]) {
        self.systems += systems.map { ($0, $0.traits) }
    }

    func update() {
        systems.forEach { $0.system.update() }
    }
}

extension Nexus
{
    func updateSystemsMembership(of entityId: EntityIdentifier) {
        let components = componentIdsByEntityId[entityId] ?? []

        systems.forEach { system, traits in
            let contains = system.has(entityId)
            let matches = traits.match(components)

            switch (contains, matches) {
            case (false, true): system.add(entityId)
            case (true, false): system.remove(entityId)
            default: break
            }
        }
    }
}
