//
//  EntityTraitSetTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 01/09/2019.
//

import XCTest
@testable import SwiftECS

final class EntityTraitSetTests: XCTestCase
{
    func test_match_one_required_method() {
        let traits = EntityTraitSet(required: [Position.self])

        XCTAssertFalse(traits.match([Velocity.id, Initiative.id]))
        XCTAssertTrue(traits.match([Velocity.id, Initiative.id, Position.id]))
    }

    func test_match_two_required_method() {
        let traits = EntityTraitSet(required: [Position.self, Velocity.self])

        XCTAssertFalse(traits.match([Velocity.id, Initiative.id]))
        XCTAssertFalse(traits.match([Initiative.id, Position.id]))
        XCTAssertTrue(traits.match([Velocity.id, Initiative.id, Position.id]))
        XCTAssertTrue(traits.match([Velocity.id, Position.id]))
    }

    func test_match_one_excluded_method() {
        let traits = EntityTraitSet(required: [Position.self], excluded: [Initiative.self])

        XCTAssertFalse(traits.match([Velocity.id, Initiative.id]))
        XCTAssertFalse(traits.match([Velocity.id, Initiative.id, Position.id]))
        XCTAssertTrue(traits.match([Velocity.id, Position.id]))
    }

    func test_match_two_excluded_method() {
        let traits = EntityTraitSet(required: [Position.self], excluded: [Initiative.self, Velocity.self])

        XCTAssertFalse(traits.match([Velocity.id, Initiative.id]))
        XCTAssertFalse(traits.match([Velocity.id, Initiative.id, Position.id]))
        XCTAssertFalse(traits.match([Velocity.id, Position.id]))
        XCTAssertTrue(traits.match([Position.id]))
    }
}

private final class Position: Component { }
private final class Velocity: Component { }
private final class Initiative: Component { }
