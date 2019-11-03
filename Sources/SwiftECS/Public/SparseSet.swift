//
//  SparseSet.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public final class SparseSet<Element>
{
    public typealias Index = Int
    public typealias Key = Int

    private(set) var elements: ContiguousArray<Element> = []
    private(set) var keys: [Key] = []

    private var indices: [Index?] = []

    private let minimumCapacity: Int

    public init(minimumCapacity: Int = 0) {
        self.minimumCapacity = minimumCapacity
        reserveCapacity(minimumCapacity)
    }
}

public extension SparseSet
{
    var count: Int { elements.count }
    var isEmpty: Bool { elements.isEmpty }

    func contains(_ key: Key) -> Bool {
        return search(key) != nil
    }

    func search(_ key: Key) -> Int? {
        guard
            key < indices.count,
            let index = indices[key],
            index < count,
            keys[index] == key
        else {
            return nil
        }

        return index
    }

    @discardableResult
    func insert(_ element: Element, at key: Key) -> Bool {
        // replace element if key already exists
        if let index = search(key) {
            elements[index] = element
            keys[index] = key

            return false
        }

        // allocate memory for sparse array if needed
        if key >= indices.count {
            reserveCapacity(key * 2 + 1)
        }

        // add new element
        elements.append(element)
        keys.append(key)
        indices[key] = elements.count - 1

        return true
    }

    func get(at key: Key) -> Element? {
        guard let index = search(key) else { return nil }
        return elements[index]
    }

    func get(unsafe key: Key) -> Element {
        let index = search(key).unsafelyUnwrapped
        return elements[index]
    }

    @discardableResult
    func remove(at key: Key) -> Element? {
        guard let index = search(key) else { return nil }

        elements.swapAt(index, elements.count - 1)
        keys.swapAt(index, keys.count - 1)
        indices[keys[index]] = index
        indices[index] = nil

        keys.removeLast()

        return elements.removeLast()
    }

    func removeAll(keepingCapacity keepCapacity: Bool = true) {
        elements.removeAll(keepingCapacity: keepCapacity)
        keys.removeAll(keepingCapacity: keepCapacity)
        indices.removeAll(keepingCapacity: keepCapacity)

        if !keepCapacity {
            reserveCapacity(minimumCapacity)
        }
    }
}

extension SparseSet: Sequence
{
    public func makeIterator() -> IndexingIterator<ContiguousArray<Element>> {
        return elements.makeIterator()
    }
}

private extension SparseSet
{
    func reserveCapacity(_ minimumCapacity: Int) {
        indices.reserveCapacity(minimumCapacity, fill: nil)
    }
}

private extension Array
{
    mutating func reserveCapacity(_ minimumCapacity: Int, fill: Element) {
        var array = [Element](repeating: fill, count: minimumCapacity)

        for index in 0..<count {
            array[index] = self[index]
        }

        self = array
    }
}
