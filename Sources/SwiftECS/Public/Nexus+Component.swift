//
//  Nexus+Component.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 25/08/2019.
//

public extension Nexus
{
    var numberOfComponents: Int { componentsByComponentId.reduce(0) { $0 + $1.value.count } }

    func assign(_ component: Component, to entityId: EntityIdentifier) {
        if componentsByComponentId[component.id] == nil {
            componentsByComponentId[component.id] = SparseSet()
        }

        componentsByComponentId[component.id]
            .unsafelyUnwrapped
            .insert(component, at: entityId.key)

        componentIdsByEntityId[entityId, default: Set()]
            .insert(component.id)

        updateSystemsMembership(of: entityId)
    }

    func remove(_ component: Component.Type, of entityId: EntityIdentifier) {
        assert(componentsByComponentId[component.id]?.contains(entityId.key) ?? false)
        assert(componentIdsByEntityId[entityId]?.contains(component.id) ?? false)

        componentsByComponentId[component.id]?
            .remove(at: entityId.key)

        componentIdsByEntityId[entityId]?
            .remove(component.id)

        updateSystemsMembership(of: entityId)
    }

    func entity(_ entityId: EntityIdentifier, has component: Component.Type) -> Bool {
        return componentsByComponentId[component.id]?
            .contains(entityId.key) ?? false
    }

    func components(of entityId: EntityIdentifier) -> [Component] {
        return componentIdsByEntityId[entityId]?
            .map { get(unsafe: $0, of: entityId) } ?? []
    }

    func get<C: Component>(_ component: C.Type, of entityId: EntityIdentifier) -> C? {
        return componentsByComponentId[component.id]?
            .get(at: entityId.key) as? C
    }

    func get<C: Component>(unsafe component: C.Type, of entityId: EntityIdentifier) -> C {
        let component = get(unsafe: component.id, of: entityId)
        return unsafeDowncast(component, to: C.self)
    }

    func get<C: Component>(for entityId: EntityIdentifier) -> C? {
        return get(C.self, of: entityId)
    }

    func get<C: Component>(for entityId: EntityIdentifier) -> C {
        return get(unsafe: C.self, of: entityId)
    }
}

private extension Nexus
{
    func get(unsafe componentId: ComponentIdentifier, of entityId: EntityIdentifier) -> Component {
        return componentsByComponentId[componentId]
            .unsafelyUnwrapped
            .get(unsafe: entityId.key)
    }
}
