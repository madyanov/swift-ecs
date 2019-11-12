//
//  NexusSystemTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 01/09/2019.
//

import XCTest
@testable import SwiftECS

final class NexusSystemTests: XCTestCase
{
    private let movementSystem = MovementSystem()
    private lazy var nexus = Nexus(systems: [movementSystem])

    func test_system_synchronization() {
        _ = nexus.makeEntity(with: Position())
        _ = nexus.makeEntity(with: Velocity())
        let entityId3 = nexus.makeEntity(with: [Position(), Velocity()])
        let entityId4 = nexus.makeEntity(with: [Position(), Velocity()])

        XCTAssertEqual(movementSystem.entityIds.count, 2)
        XCTAssertEqual(movementSystem.entityIds.elements, [entityId3, entityId4])

        nexus.remove(Position.self, of: entityId3)
        XCTAssertEqual(movementSystem.entityIds.count, 1)
        XCTAssertEqual(movementSystem.entityIds.elements, [entityId4])

        nexus.removeEntity(entityId4)
        XCTAssertTrue(movementSystem.entityIds.isEmpty)
    }

    func test_non_existing_entity_removing() {
        let entityId = nexus.makeEntity(with: Position())
        XCTAssertFalse(movementSystem.removeMethodCalled)

        nexus.removeEntity(entityId)
        XCTAssertFalse(movementSystem.removeMethodCalled)
    }
}

private final class MovementSystem: System
{
    var removeMethodCalled = false

    let traits = EntityTraitSet(required: [Position.self, Velocity.self])
    let entityIds = SparseSet<EntityIdentifier>()

    func has(_ entityId: EntityIdentifier) -> Bool {
        return entityIds.contains(entityId)
    }

    func add(_ entityId: EntityIdentifier) {
        entityIds.insert(entityId)
    }

    func remove(_ entityId: EntityIdentifier) {
        entityIds.remove(entityId)
        removeMethodCalled = true
    }

    func update() { }
}

private final class Position: Component { }
private final class Velocity: Component { }
