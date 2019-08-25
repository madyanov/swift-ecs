//
//  Nexus+Entity.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    var numberOfEntities: Int {
        return entityIds.count
    }

    func makeEntity(with components: Component...) -> Entity {
        let identifier = entityIdsPool.take()
        let entity = Entity(nexus: self, identifier: identifier)

        components.forEach {
            assign($0, to: identifier)
        }

        entityIds.insert(identifier, at: identifier.index)

        return entity
    }

    func removeEntity(_ entityId: EntityIdentifier) {
        assert(entityIds.contains(entityId.index))
        assert(componentIdsByEntityId[entityId] != nil)

        entityIdsPool.free(entityId)
        entityIds.remove(at: entityId.index)

        for componentId in componentIdsByEntityId[entityId] ?? [] {
            assert(componentsByComponentIds[componentId]?.contains(entityId.index) ?? false)

            componentsByComponentIds[componentId]
                .unsafelyUnwrapped
                .remove(at: entityId.index)
        }

        componentIdsByEntityId.removeValue(forKey: entityId)

        for entities in entityIdsByTraits.values {
            entities.remove(at: entityId.index)
        }
    }
}
