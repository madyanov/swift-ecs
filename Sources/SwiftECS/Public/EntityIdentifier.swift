//
//  EntityIdentifier.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct EntityIdentifier
{
    let key: Int

    init(_ index: UInt32 = 0) {
        self.key = Int(index)
    }
}

extension EntityIdentifier: Identifiable
{
    public var id: Int {
        return key
    }
}

extension EntityIdentifier: Hashable { }
