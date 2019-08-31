//
//  UnorderedSparseSet+Identifiable.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 31/08/2019.
//

public extension UnorderedSparseSet where Element: Identifiable, Element.ID == Key
{
    func contains(_ element: Element) -> Bool {
        return search(element) != nil
    }

    func search(_ element: Element) -> Int? {
        return search(element.id)
    }

    @discardableResult
    func insert(_ element: Element) -> Bool {
        return insert(element, at: element.id)
    }

    @discardableResult
    func remove(_ element: Element) -> Element? {
        return remove(at: element.id)
    }
}
