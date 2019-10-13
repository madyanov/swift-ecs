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

    func test_systems_synchronization() {
        nexus.addSystem(movementSystem)

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

private final class MovementSystem: SparseSetBakedSystem
{
    override var traits: EntityTraitSet { EntityTraitSet(required: [Position.self, Velocity.self]) }
}

private final class Position: Component { }
private final class Velocity: Component { }
