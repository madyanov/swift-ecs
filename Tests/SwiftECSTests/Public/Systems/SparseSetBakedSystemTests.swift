//
//  SparseSetBakedSystemTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 13.10.2019.
//

import XCTest
@testable import SwiftECS

final class SparseSetBakedSystemTests: XCTestCase
{
    private lazy var movementSystem = MovementSystem(nexus: nexus)
    private lazy var nexus = Nexus()

    override func setUp() {
        super.setUp()
        nexus.addSystem(movementSystem)
    }

    func test_system_synchronization() {
        _ = nexus.makeEntity(with: Position())
        _ = nexus.makeEntity(with: Velocity())
        let entityId3 = nexus.makeEntity(with: [Position(), Velocity()])
        let entityId4 = nexus.makeEntity(with: [Position(), Velocity()])

        XCTAssertEqual(movementSystem.entityIds.count, 2)
        XCTAssertEqual(movementSystem.entityIds.elements, [entityId3, entityId4])

        nexus.remove(Position.self, from: entityId3)
        XCTAssertEqual(movementSystem.entityIds.count, 1)
        XCTAssertEqual(movementSystem.entityIds.elements, [entityId4])

        nexus.removeEntity(entityId4)
        XCTAssertTrue(movementSystem.entityIds.isEmpty)
    }

    func test_component_removing_while_iterating() {
        let entityId1 = nexus.makeEntity(with: [Position(), Velocity()])
        let entityId2 = nexus.makeEntity(with: [Position(), Velocity()])
        XCTAssertEqual(movementSystem.entityIds.count, 2)

        let entityIds = movementSystem.removePositionComponent()
        XCTAssertEqual(movementSystem.entityIds.count, 0)
        XCTAssertEqual(entityIds, [entityId1, entityId2])
    }
}

private final class MovementSystem: SparseSetBackedSystem
{
    override var traits: EntityTraitSet { EntityTraitSet(required: [Position.self, Velocity.self]) }

    func removePositionComponent() -> [EntityIdentifier] {
        var removedEntityIds: [EntityIdentifier] = []

        for entityId in entityIds {
            removedEntityIds.append(entityId)
            nexus.remove(Position.self, from: entityId)
        }

        return removedEntityIds
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
