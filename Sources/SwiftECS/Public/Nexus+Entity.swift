//
//  Nexus+Entity.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    var numberOfEntities: Int { entityIds.count }

    func makeEntity(with component: Component) -> EntityIdentifier {
        return makeEntity(with: [component])
    }

    func makeEntity(with components: [Component] = []) -> EntityIdentifier {
        let identifier = entityIdsPool.take()
        components.forEach { assign($0, to: identifier) }
        entityIds.insert(identifier)
        return identifier
    }

    func removeEntity(_ entityId: EntityIdentifier) {
        assert(entityIds.contains(entityId))

        entityIdsPool.free(entityId)
        entityIds.remove(entityId)

        for componentId in componentIdsByEntityId[entityId] ?? [] {
            assert(componentsByComponentIds[componentId]?.contains(entityId.key) ?? false)

            componentsByComponentIds[componentId]
                .unsafelyUnwrapped
                .remove(at: entityId.key)
        }

        componentIdsByEntityId.removeValue(forKey: entityId)

        updateSystemsMembership(of: entityId)
    }
}
