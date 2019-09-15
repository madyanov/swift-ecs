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

    func test_nexus_setting() {
        _ = nexus // lazy initialization
        XCTAssertTrue(movementSystem.nexus === nexus)
    }

    func test_systems_synchronization() {
        _ = nexus.makeEntity(with: Position())
        _ = nexus.makeEntity(with: Velocity())
        let entityId3 = nexus.makeEntity(with: Position(), Velocity())
        let entityId4 = nexus.makeEntity(with: Position(), Velocity())

        XCTAssertEqual(movementSystem.entities.count, 2)
        XCTAssertEqual(movementSystem.entities.elements, [entityId3, entityId4])

        nexus.remove(Position.self, from: entityId3)
        XCTAssertEqual(movementSystem.entities.count, 1)
        XCTAssertEqual(movementSystem.entities.elements, [entityId4])

        nexus.removeEntity(entityId4)
        XCTAssertTrue(movementSystem.entities.isEmpty)
    }
}

private final class MovementSystem: System
{
    unowned var nexus: Nexus!

    let traits = EntityTraitSet(required: [Position.self, Velocity.self])
    let entities = UnorderedSparseSet<EntityIdentifier>()

    func add(_ entityId: EntityIdentifier) {
        entities.insert(entityId)
    }

    func remove(_ entityId: EntityIdentifier) {
        entities.remove(entityId)
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
