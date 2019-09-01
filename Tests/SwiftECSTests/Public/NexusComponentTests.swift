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
    private let nexus = Nexus(systems: [])

    func test_has_method() {
        let entityId = nexus.makeEntity()

        XCTAssertFalse(nexus.entity(entityId, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId, has: Velocity.self))

        nexus.assign(Position(), to: entityId)
        XCTAssertTrue(nexus.entity(entityId, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId, has: Velocity.self))

        nexus.remove(Position.self, from: entityId)
        XCTAssertFalse(nexus.entity(entityId, has: Position.self))
        XCTAssertFalse(nexus.entity(entityId, has: Velocity.self))
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
private final class Initiative: Component { }
