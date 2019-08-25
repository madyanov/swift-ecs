//
//  Nexus+Entity.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    func makeEntity(with components: Component...) -> Entity {
        let identifier = entityIdsPool.take()
        let entity = Entity(identifier: identifier)
        components.forEach { assign($0, to: entity) }
        return entity
    }

    func removeEntity(_ entity: Entity) {
        assert(componentIdsByEntityId[entity.identifier] != nil)

        entityIdsPool.free(entity.identifier)

        for componentId in componentIdsByEntityId[entity.identifier] ?? [] {
            componentsByComponentIds[componentId]
                .unsafelyUnwrapped
                .remove(for: entity.identifier.index)
        }

        componentIdsByEntityId.removeValue(forKey: entity.identifier)

        for entities in entitiesByTraits.values {
            entities.remove(for: entity.identifier.index)
        }
    }
}
