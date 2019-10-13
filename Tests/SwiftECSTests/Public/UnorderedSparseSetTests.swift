//
//  UnorderedSparseSetTests.swift
//  SwiftECSTests
//
//  Created by Roman Madyanov on 24/08/2019.
//

import XCTest
@testable import SwiftECS

final class UnorderedSparseSetTests: XCTestCase
{
    private let set = UnorderedSparseSet<Int>()

    func test_count_and_isEmpty_properties() {
        let element1 = 42
        let element2 = 33

        XCTAssertEqual(set.count, 0)
        XCTAssertTrue(set.isEmpty)

        set.insert(element1)
        XCTAssertEqual(set.count, 1)
        XCTAssertFalse(set.isEmpty)

        set.insert(element2)
        XCTAssertEqual(set.count, 2)
        XCTAssertFalse(set.isEmpty)

        set.remove(element1)
        XCTAssertEqual(set.count, 1)
        XCTAssertFalse(set.isEmpty)

        set.remove(element2)
        XCTAssertEqual(set.count, 0)
        XCTAssertTrue(set.isEmpty)
    }

    func test_contains_method() {
        let element = 42

        XCTAssertFalse(set.contains(element))

        set.insert(42)
        XCTAssertTrue(set.contains(element))

        set.remove(element)
        XCTAssertFalse(set.contains(element))
    }

    func test_search_method() {
        let element1 = 42
        let element2 = 33

        XCTAssertNil(set.search(element1))
        XCTAssertNil(set.search(element2))

        set.insert(element1)
        XCTAssertEqual(set.search(element1), 0)

        set.insert(element2)
        XCTAssertEqual(set.search(element2), 1)

        set.remove(element1)
        XCTAssertNil(set.search(element1))
        XCTAssertEqual(set.search(element2), 0)
    }

    func test_insert_method() {
        let element1 = 42
        let element2 = 33

        XCTAssertTrue(set.insert(element1))
        XCTAssertTrue(set.insert(element2))
        XCTAssertEqual(set.count, 2)

        XCTAssertFalse(set.insert(element1))
        XCTAssertFalse(set.insert(element2))
        XCTAssertEqual(set.count, 2)
    }

    func test_get_method() {
        let element1 = 42
        let element2 = 33

        XCTAssertNil(set.get(at: 0))
        XCTAssertNil(set.get(at: 1))

        set.insert(element1, at: 0)
        set.insert(element2, at: 1)
        XCTAssertEqual(set.get(at: 0), element1)
        XCTAssertEqual(set.get(at: 1), element2)
        XCTAssertEqual(set.get(unsafe: 0), element1)
        XCTAssertEqual(set.get(unsafe: 1), element2)

        set.remove(at: 0)
        XCTAssertNil(set.get(at: 0))
        XCTAssertEqual(set.get(at: 1), element2)
        XCTAssertEqual(set.get(unsafe: 1), element2)
    }

    func test_remove_method() {
        let element1 = 42
        let element2 = 33
        let element3 = 777

        set.insert(element1)
        set.insert(element2)

        XCTAssertEqual(set.remove(element1), 42)
        XCTAssertEqual(set.count, 1)

        XCTAssertEqual(set.remove(element2), 33)
        XCTAssertEqual(set.count, 0)

        XCTAssertNil(set.remove(element3))
        XCTAssertEqual(set.count, 0)

        XCTAssertFalse(set.contains(element1))
        XCTAssertFalse(set.contains(element2))
    }

    func test_removeAll_method() {
        let element1 = 42
        let element2 = 33

        XCTAssertTrue(set.isEmpty)

        set.insert(element1)
        set.insert(element2)
        XCTAssertFalse(set.isEmpty)

        set.removeAll()
        XCTAssertTrue(set.isEmpty)
    }

    func test_elements_and_keys_properties() {
        let element1 = 42
        let element2 = 33

        set.insert(element1, at: 0)
        set.insert(element2, at: 1)
        XCTAssertEqual(set.elements, [42, 33])
        XCTAssertEqual(set.keys, [0, 1])

        set.remove(at: 0)
        XCTAssertEqual(set.elements, [33])
        XCTAssertEqual(set.keys, [1])
    }

    func test_sequence_implementation() {
        let element1 = 42
        let element2 = 33
        let element3 = 777

        set.insert(element1)
        set.insert(element2)
        set.insert(element3)
        XCTAssertEqual(set.map { $0 }, [42, 33, 777])

        set.remove(element2)
        XCTAssertEqual(set.map { $0 }, [42, 777])
    }
}

extension Int: Identifiable
{
    public var id: Int { self }
}
