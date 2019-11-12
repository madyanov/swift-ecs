//
//  NexusComponentTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 01/09/2019.
//

import XCTest
@testable import SwiftECS

final class NexusComponentTests: XCTestCase
{
    private let nexus = Nexus()

    func test_has_method() {
        let entityId = nexus.makeEntity()

        XCTAssertFalse(nexus.entity(entityId, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId, has: Velocity.self))

        nexus.assign(Position(x: 42, y: 33), to: entityId)
        XCTAssertTrue(nexus.entity(entityId, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId, has: Velocity.self))
    }

    func test_component_removing() {
        let entityId = nexus.makeEntity(with: Position(x: 42, y: 33))

        XCTAssertTrue(nexus.entity(entityId, has: Position.self))

        nexus.remove(Position.self, of: entityId)
        XCTAssertFalse(nexus.entity(entityId, has: Position.self))
    }

    func test_get_method_and_component_updating() {
        let entityId = nexus.makeEntity()

        let position1: Position? = nexus.get(for: entityId)
        XCTAssertNil(position1)

        nexus.assign(Position(x: 42, y: 33), to: entityId)
        let position2: Position? = nexus.get(for: entityId)
        let unsafePosition: Position = nexus.get(for: entityId)
        XCTAssertEqual(position2?.x, 42)
        XCTAssertEqual(position2?.y, 33)
        XCTAssertEqual(unsafePosition.x, position2?.x)
        XCTAssertEqual(unsafePosition.y, position2?.y)

        unsafePosition.x = 777
        let position3: Position = nexus.get(for: entityId)
        XCTAssertEqual(position3.x, 777)
        XCTAssertEqual(position3.y, 33)
    }

    func test_numberOfComponents_property() {
        XCTAssertEqual(nexus.numberOfComponents, 0)

        let entityId1 = nexus.makeEntity(with: Velocity())
        XCTAssertEqual(nexus.numberOfComponents, 1)

        let entityId2 = nexus.makeEntity(with: [Velocity(), Initiative()])
        XCTAssertEqual(nexus.numberOfComponents, 3)

        nexus.removeEntity(entityId1)
        XCTAssertEqual(nexus.numberOfComponents, 2)

        nexus.remove(Velocity.self, of: entityId2)
        XCTAssertEqual(nexus.numberOfComponents, 1)

        nexus.removeEntity(entityId2)
        XCTAssertEqual(nexus.numberOfComponents, 0)
    }

    func test_component_replacing() {
        let entityId = nexus.makeEntity()

        nexus.assign(Position(x: 42, y: 33), to: entityId)
        let position1: Position = nexus.get(for: entityId)
        XCTAssertEqual(position1.x, 42)
        XCTAssertEqual(position1.y, 33)

        nexus.assign(Position(x: 43, y: 34), to: entityId)
        let position2: Position = nexus.get(for: entityId)
        XCTAssertEqual(position2.x, 43)
        XCTAssertEqual(position2.y, 34)
    }
}

private final class Position: Component
{
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

private final class Velocity: Component { }
private final class Initiative: Component { }
