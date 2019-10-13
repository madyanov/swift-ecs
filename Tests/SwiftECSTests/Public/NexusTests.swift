//
//  NexusTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 01/09/2019.
//

import XCTest
@testable import SwiftECS

final class NexusTests: XCTestCase
{
    private let movementSystem = MovementSystem()
    private lazy var nexus = Nexus(systems: [movementSystem])

    func test_systems_synchronization() {
        _ = nexus.makeEntity(with: Position())
        _ = nexus.makeEntity(with: Velocity())
        let entityId3 = nexus.makeEntity(with: Position(), Velocity())
        let entityId4 = nexus.makeEntity(with: Position(), Velocity())

        XCTAssertEqual(movementSystem.entityIds.count, 2)
        XCTAssertEqual(movementSystem.entityIds.elements, [entityId3, entityId4])

        nexus.remove(Position.self, from: entityId3)
        XCTAssertEqual(movementSystem.entityIds.count, 1)
        XCTAssertEqual(movementSystem.entityIds.elements, [entityId4])

        nexus.removeEntity(entityId4)
        XCTAssertTrue(movementSystem.entityIds.isEmpty)
    }
}

private final class MovementSystem: System
{
    let traits = EntityTraitSet(required: [Position.self, Velocity.self])
    let entityIds = UnorderedSparseSet<EntityIdentifier>()

    func add(_ entityId: EntityIdentifier) {
        entityIds.insert(entityId)
    }

    func remove(_ entityId: EntityIdentifier) {
        entityIds.remove(entityId)
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
