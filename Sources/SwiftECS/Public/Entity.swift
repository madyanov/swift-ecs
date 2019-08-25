//
//  Entity.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct Entity
{
    let identifier: EntityIdentifier

    init(identifier: EntityIdentifier) {
        self.identifier = identifier
    }
}
