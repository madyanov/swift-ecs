//
//  CleanupSystemTests.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 16.10.2019.
//

import XCTest
@testable import SwiftECS

final class CleanupSystemSystemTests: XCTestCase
{
    private lazy var cleanupSystem = CleanupSystem<Position>(nexus: nexus)
    private lazy var nexus = Nexus()

    override func setUp() {
        super.setUp()
        nexus.addSystem(cleanupSystem)
    }

    func test_entities_removing() {
        let entityId1 = nexus.makeEntity(with: Position())
        let entityId2 = nexus.makeEntity(with: Position())
        let entityId3 = nexus.makeEntity(with: Velocity())

        XCTAssertEqual(nexus.numberOfEntities, 3)
        XCTAssertEqual(nexus.entityIds.elements, [entityId1, entityId2, entityId3])

        cleanupSystem.removeEntities()
        XCTAssertEqual(nexus.numberOfEntities, 1)
        XCTAssertEqual(nexus.entityIds.elements, [entityId3])
    }

    func test_component_removing() {
        let entityId1 = nexus.makeEntity(with: Position())
        let entityId2 = nexus.makeEntity(with: Position())
        let entityId3 = nexus.makeEntity(with: Velocity())

        cleanupSystem.removeComponent()
        XCTAssertFalse(nexus.entity(entityId1, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId2, has: Position.self))
        XCTAssertTrue(nexus.entity(entityId3, has: Velocity.self))
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
