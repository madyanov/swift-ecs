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

    func test_component_removing_while_iterating() {
        let _ = nexus.makeEntity(with: Position(), Velocity())
        let _ = nexus.makeEntity(with: Position(), Velocity())
        XCTAssertEqual(movementSystem.entityIds.count, 2)

        movementSystem.removeEntitiesWithPosition()
        XCTAssertEqual(movementSystem.entityIds.count, 0)
    }
}

private final class MovementSystem: SparseSetBakedSystem
{
    override var traits: EntityTraitSet { EntityTraitSet(required: [Position.self, Velocity.self]) }

    func removeEntitiesWithPosition() {
        entityIds.forEach { nexus.remove(Position.self, from: $0) }
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
