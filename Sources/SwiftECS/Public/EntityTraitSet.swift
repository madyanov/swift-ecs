//
//  EntityTraitSet.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public struct EntityTraitSet
{
    private let required: Set<ComponentIdentifier>
    private let excluded: Set<ComponentIdentifier>

    public init(required: [Component.Type] = [], excluded: [Component.Type] = []) {
        self.required = Set(required.map { $0.identifier })
        self.excluded = Set(excluded.map { $0.identifier })

        assert(!self.required.isEmpty && self.required.isDisjoint(with: self.excluded))
    }
}

public extension EntityTraitSet
{
    func match(_ components: Set<ComponentIdentifier>) -> Bool {
        return required.isSubset(of: components)
            && excluded.isDisjoint(with: components)
    }
}

extension EntityTraitSet: Hashable { }
