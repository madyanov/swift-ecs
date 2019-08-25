//
//  Entity.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct Entity
{
    let identifier: EntityIdentifier

    private unowned let nexus: Nexus

    init(nexus: Nexus, identifier: EntityIdentifier) {
        self.nexus = nexus
        self.identifier = identifier
    }
}
