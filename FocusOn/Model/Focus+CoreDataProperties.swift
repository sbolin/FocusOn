//
//  Focus+CoreDataProperties.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/18/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//
//

import Foundation
import CoreData


extension Focus {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Focus> {
        return NSFetchRequest<Focus>(entityName: "Focus")
    }

    @NSManaged public var goal: String
    @NSManaged public var dateCreated: Date
    @NSManaged public var todos: NSSet

}

// MARK: Generated accessors for todos
extension Focus {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: ToDo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: ToDo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}
