//
//  EntityIdentifier.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

struct EntityIdentifier
{
    let index: Int

    init(_ index: UInt32 = 0) {
        self.index = Int(index)
    }
}

extension EntityIdentifier: Hashable { }
