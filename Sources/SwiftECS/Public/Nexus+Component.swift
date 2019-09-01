//
//  Nexus+Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    var numberOfComponents: Int {
        return componentsByComponentIds.reduce(0) { $0 + $1.value.count }
    }

    func assign(_ component: Component, to entityId: EntityIdentifier) {
        assert(componentsByComponentIds[component.id]?.contains(entityId.key) ?? false == false)
        assert(componentIdsByEntityId[entityId]?.contains(component.id) ?? false == false)

        if componentsByComponentIds[component.id] == nil {
            componentsByComponentIds[component.id] = UnorderedSparseSet()
        }

        componentsByComponentIds[component.id]
            .unsafelyUnwrapped
            .insert(component, at: entityId.key)

        componentIdsByEntityId[entityId, default: Set()]
            .insert(component.id)

        updateSystemsMembership(of: entityId)
    }

    func remove(_ component: Component.Type, from entityId: EntityIdentifier) {
        assert(componentsByComponentIds[component.id]?.contains(entityId.key) ?? false)
        assert(componentIdsByEntityId[entityId]?.contains(component.id) ?? false)

        componentsByComponentIds[component.id]?
            .remove(at: entityId.key)

        componentIdsByEntityId[entityId]?
            .remove(component.id)

        updateSystemsMembership(of: entityId)
    }

    func entity(_ entityId: EntityIdentifier, has component: Component.Type) -> Bool {
        return componentsByComponentIds[component.id]?
            .contains(entityId.key) ?? false
    }

    func get<C: Component>(_ component: C.Type, of entityId: EntityIdentifier) -> C? {
        return componentsByComponentIds[component.id]?
            .get(at: entityId.key) as? C
    }

    func get<C: Component>(unsafe component: C.Type, of entityId: EntityIdentifier) -> C {
        let component = componentsByComponentIds[component.id]
            .unsafelyUnwrapped
            .get(unsafe: entityId.key)

        return unsafeDowncast(component, to: C.self)
    }

    func get<C: Component>(_ entityId: EntityIdentifier) -> C? {
        return get(C.self, of: entityId)
    }

    func get<C: Component>(_ entityId: EntityIdentifier) -> C {
        return get(unsafe: C.self, of: entityId)
    }
}

private extension Nexus
{
    func updateSystemsMembership(of entityId: EntityIdentifier) {
        guard let components = componentIdsByEntityId[entityId] else {
            return
        }

        systems.forEach { system in
            if system.traits.match(components) {
                system.add(entityId)
            } else {
                system.remove(entityId)
            }
        }
    }
}
