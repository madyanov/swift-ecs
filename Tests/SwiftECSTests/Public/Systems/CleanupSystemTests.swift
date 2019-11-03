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

    func test_component_removing() {
        let entityId1 = nexus.makeEntity(with: Position())
        let entityId2 = nexus.makeEntity(with: Position())
        let entityId3 = nexus.makeEntity(with: Velocity())

        nexus.update()
        XCTAssertFalse(nexus.entity(entityId1, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId2, has: Position.self))
        XCTAssertTrue(nexus.entity(entityId3, has: Velocity.self))
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
