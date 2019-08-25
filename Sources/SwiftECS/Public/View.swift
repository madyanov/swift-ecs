//
//  View.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 24/08/2019.
//

public final class View<R: ViewRequirements>
{

}

public protocol ViewRequirements
{
    associatedtype Components

    static func components(nexus: Nexus, entity: Entity) -> Components
}

public struct ViewRequirements1<A: Component>: ViewRequirements
{
    
}
