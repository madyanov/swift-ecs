//
//  EntityIdentifiersPool.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

final class EntityIdentifiersPool
{
    private var identifier = EntityIdentifier()
    private var freeIdentifiers: [EntityIdentifier] = []
}

extension EntityIdentifiersPool
{
    func take() -> EntityIdentifier {
        if let identifier = freeIdentifiers.popLast() {
            return identifier
        }

        defer { identifier = EntityIdentifier(UInt32(identifier.index + 1)) }
        return identifier
    }

    func free(_ identifier: EntityIdentifier) {
        freeIdentifiers.append(identifier)
    }

    func flush() {
        identifier = EntityIdentifier()
    }
}
