//
//  EntityIdentifiersPool.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

final class EntityIdentifiersPool
{
    private var id = EntityIdentifier()
    private var freeIds: [EntityIdentifier] = []
}

extension EntityIdentifiersPool
{
    var numberOfEntities: Int {
        return id.key - freeIds.count
    }

    func take() -> EntityIdentifier {
        if let id = freeIds.popLast() {
            return id
        }

        defer { id = EntityIdentifier(UInt32(id.key + 1)) }
        return id
    }

    func free(_ id: EntityIdentifier) {
        freeIds.append(id)
    }

    func flush() {
        freeIds = []
        id = EntityIdentifier()
    }
}
