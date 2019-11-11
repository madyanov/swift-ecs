//
//  NexusEntityTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 01/09/2019.
//

import XCTest
@testable import SwiftECS

final class NexusEntityTests: XCTestCase
{
    private let nexus = Nexus()

    func test_entity_creation() {
        XCTAssertEqual(nexus.makeEntity().id, 0)
        XCTAssertEqual(nexus.makeEntity().id, 1)
    }

    func test_numberOfEntities_property() {
        XCTAssertEqual(nexus.numberOfEntities, 0)

        let entityId1 = nexus.makeEntity()
        let entityId2 = nexus.makeEntity()
        XCTAssertEqual(nexus.numberOfEntities, 2)

        nexus.removeEntity(entityId1)
        XCTAssertEqual(nexus.numberOfEntities, 1)

        nexus.removeEntity(entityId2)
        XCTAssertEqual(nexus.numberOfEntities, 0)

        XCTAssertEqual(nexus.makeEntity().id, 1)
        XCTAssertEqual(nexus.makeEntity().id, 0)
    }
}
