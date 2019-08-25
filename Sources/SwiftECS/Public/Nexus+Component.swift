//
//  Nexus+Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    var numberOfComponents: Int {
        return componentsByComponentIDs.reduce(0) { $0 + $1.value.count }
    }

    func assign(_ component: Component, to entity: Entity) {
        assert(componentsByComponentIDs[component.identifier]?.contains(entity.identifier.index) ?? false == false)
        assert(componentIDsByEntityID[entity.identifier]?.contains(component.identifier) ?? false == false)

        componentsByComponentIDs[component.identifier, default: UnorderedSparseSet()]
            .insert(component, for: entity.identifier.index)

        componentIDsByEntityID[entity.identifier, default: Set()]
            .insert(component.identifier)

        updateTraitsMembership(for: entity)
    }

    func remove(_ component: Component.Type, from entity: Entity) {
        assert(componentsByComponentIDs[component.identifier]?.contains(entity.identifier.index) ?? false)
        assert(componentIDsByEntityID[entity.identifier]?.contains(component.identifier) ?? false)

        componentsByComponentIDs[component.identifier]?
            .remove(for: entity.identifier.index)

        componentIDsByEntityID[entity.identifier]?
            .remove(component.identifier)

        updateTraitsMembership(for: entity)
    }

    func entity(_ entity: Entity, has component: Component.Type) -> Bool {
        return componentsByComponentIDs[component.identifier]?
            .contains(entity.identifier.index) ?? false
    }

    func get<C: Component>(_ component: C.Type, of entity: Entity) -> C? {
        return componentsByComponentIDs[component.identifier]?
            .get(for: entity.identifier.index) as? C
    }

    func get<C: Component>(unsafe component: C.Type, of entity: Entity) -> C {
        let component = componentsByComponentIDs[component.identifier]
            .unsafelyUnwrapped
            .get(unsafe: entity.identifier.index)

        return unsafeDowncast(component, to: C.self)
    }
}

private extension Nexus
{
    func updateTraitsMembership(for entity: Entity) {
        guard let components = componentIDsByEntityID[entity.identifier] else {
            return
        }

        entitiesByTraits.forEach { traits, entities in
            if traits.match(components) {
                entities.insert(entity, for: entity.identifier.index)
            } else {
                entities.remove(for: entity.identifier.index)
            }
        }
    }
}
