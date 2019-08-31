//
//  Identifiable.swift
//  SwiftECS
//
//  Created by Roman Madyanov on 31/08/2019.
//

public protocol Identifiable
{
    associatedtype ID

    var id: ID { get }
}
