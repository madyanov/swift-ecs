//
//  Nexus+Entity.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    func makeEntity(with components: Component...) -> Entity {
        let identifier = entityIDsPool.take()
        let entity = Entity(identifier: identifier)
        components.forEach { assign($0, to: entity) }
        return entity
    }

    func removeEntity(_ entity: Entity) {
        assert(componentIDsByEntityID[entity.identifier] != nil)

        entityIDsPool.free(entity.identifier)

        for componentID in componentIDsByEntityID[entity.identifier] ?? [] {
            componentsByComponentIDs[componentID]
                .unsafelyUnwrapped
                .remove(for: entity.identifier.index)
        }

        componentIDsByEntityID.removeValue(forKey: entity.identifier)

        for entities in entitiesByTraits.values {
            entities.remove(for: entity.identifier.index)
        }
    }
}
