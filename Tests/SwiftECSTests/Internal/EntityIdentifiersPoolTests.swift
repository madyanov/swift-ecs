//
//  EntityIdentifiersPoolTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 01/09/2019.
//

import XCTest
@testable import SwiftECS

final class EntityIdentifiersPoolTests: XCTestCase
{
    private let pool = EntityIdentifiersPool()

    func test_take_method() {
        XCTAssertEqual(pool.take().key, 0)
        XCTAssertEqual(pool.take().key, 1)
        XCTAssertEqual(pool.take().key, 2)
    }

    func test_free_method() {
        XCTAssertEqual(pool.take().key, 0)
        XCTAssertEqual(pool.take().key, 1)
        XCTAssertEqual(pool.take().key, 2)

        pool.free(EntityIdentifier(1))
        XCTAssertEqual(pool.take().key, 1)
        XCTAssertEqual(pool.take().key, 3)
    }

    func test_flush_method() {
        XCTAssertEqual(pool.take().key, 0)
        XCTAssertEqual(pool.take().key, 1)
        XCTAssertEqual(pool.take().key, 2)

        pool.flush()
        XCTAssertEqual(pool.take().key, 0)
        XCTAssertEqual(pool.take().key, 1)
        XCTAssertEqual(pool.take().key, 2)
    }
}
