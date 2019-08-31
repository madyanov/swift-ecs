//
//  EntityIdentifier.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct EntityIdentifier
{
    let index: Int

    init(_ index: UInt32 = 0) {
        self.index = Int(index)
    }
}

extension EntityIdentifier: Identifiable
{
    public var id: Int {
        return index
    }
}

extension EntityIdentifier: Hashable { }
