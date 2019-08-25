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
        assert(componentsByComponentIds[component.identifier]?.contains(entityId.index) ?? false == false)
        assert(componentIdsByEntityId[entityId]?.contains(component.identifier) ?? false == false)

        componentsByComponentIds[component.identifier, default: UnorderedSparseSet()]
            .insert(component, at: entityId.index)

        componentIdsByEntityId[entityId, default: Set()]
            .insert(component.identifier)

        updateTraitsMembership(of: entityId)
    }

    func remove(_ component: Component.Type, from entityId: EntityIdentifier) {
        assert(componentsByComponentIds[component.identifier]?.contains(entityId.index) ?? false)
        assert(componentIdsByEntityId[entityId]?.contains(component.identifier) ?? false)

        componentsByComponentIds[component.identifier]?
            .remove(at: entityId.index)

        componentIdsByEntityId[entityId]?
            .remove(component.identifier)

        updateTraitsMembership(of: entityId)
    }

    func entity(_ entityId: EntityIdentifier, has component: Component.Type) -> Bool {
        return componentsByComponentIds[component.identifier]?
            .contains(entityId.index) ?? false
    }

    func get<C: Component>(_ component: C.Type, of entityId: EntityIdentifier) -> C? {
        return componentsByComponentIds[component.identifier]?
            .get(at: entityId.index) as? C
    }

    func get<C: Component>(unsafe component: C.Type, of entityId: EntityIdentifier) -> C {
        let component = componentsByComponentIds[component.identifier]
            .unsafelyUnwrapped
            .get(unsafeAt: entityId.index)

        return unsafeDowncast(component, to: C.self)
    }
}

private extension Nexus
{
    func updateTraitsMembership(of entityId: EntityIdentifier) {
        guard let components = componentIdsByEntityId[entityId] else {
            return
        }

        entityIdsByTraits.forEach { traits, entities in
            if traits.match(components) {
                entities.insert(entityId, at: entityId.index)
            } else {
                entities.remove(at: entityId.index)
            }
        }
    }
}
