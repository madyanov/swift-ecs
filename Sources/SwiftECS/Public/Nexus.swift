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

public extension Nexus
{
    func makeEntity() -> Entity {
        let identifier = entityIDsPool.take()
        let entity = Entity(identifier: identifier)
        return entity
    }

    func removeEntity(_ entity: Entity) {
        entityIDsPool.free(entity.identifier)

        for componentID in componentIDsByEntityID[entity.identifier] ?? [] {
            componentsByComponentIDs[componentID]
                .unsafelyUnwrapped
                .remove(for: entity.identifier.index)
        }

        componentIDsByEntityID.removeValue(forKey: entity.identifier)

        for (traits, _) in entitiesByTraits {
            entitiesByTraits[traits]
                .unsafelyUnwrapped
                .remove(for: entity.identifier.index)
        }
    }

    func entity(_ entity: Entity, has component: Component.Type) -> Bool {
        return componentsByComponentIDs[component.identifier]?
            .contains(entity.identifier.index) ?? false
    }

    func assign<C: Component>(_ component: C, to entity: Entity) {
        componentsByComponentIDs[C.identifier, default: UnorderedSparseSet()]
            .insert(component, for: entity.identifier.index)

        componentIDsByEntityID[entity.identifier, default: Set()]
            .insert(C.identifier)

        add(entity)
    }

    func remove(_ component: Component.Type, from entity: Entity) {
        componentsByComponentIDs[component.identifier]?
            .remove(for: entity.identifier.index)

        componentIDsByEntityID[entity.identifier]?
            .remove(component.identifier)

        remove(entity)
    }
}

private extension Nexus
{
    func add(_ entity: Entity) {
        guard let components = componentIDsByEntityID[entity.identifier] else {
            return
        }

        for (traits, _) in entitiesByTraits where traits.match(components) {
            entitiesByTraits[traits]
                .unsafelyUnwrapped
                .insert(entity, for: entity.identifier.index)
        }
    }

    func remove(_ entity: Entity) {
        guard let components = componentIDsByEntityID[entity.identifier] else {
            return
        }

        for (traits, _) in entitiesByTraits where !traits.match(components) {
            entitiesByTraits[traits]
                .unsafelyUnwrapped
                .remove(for: entity.identifier.index)
        }
    }
}
