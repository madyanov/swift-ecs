//
//  EntityIdentifier.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct EntityIdentifier
{
    let key: Int

    init(_ key: UInt32 = 0) {
        self.key = Int(key)
    }
}

extension EntityIdentifier: Identifiable
{
    public var id: Int {
        return key
    }
}

extension EntityIdentifier: Hashable { }
