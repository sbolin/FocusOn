//
//  Goal+CoreDataProperties.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/24/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {
  
  @nonobjc public class func createFetchRequest() -> NSFetchRequest<Goal> {
    return NSFetchRequest<Goal>(entityName: "Goal")
  }
  @NSManaged public var goal: String
  @NSManaged public var completedGoal: Bool
  @NSManaged public var dateCreated: Date
  @NSManaged public var todos: Set<ToDo>?
  
}

// MARK: Generated accessors for todos
extension Goal {
  
  @objc(addTodosObject:)
  @NSManaged public func addToTodos(_ value: ToDo)
  
  @objc(removeTodosObject:)
  @NSManaged public func removeFromTodos(_ value: ToDo)
  
  @objc(addTodos:)
  @NSManaged public func addToTodos(_ values: Set<ToDo>)
  
  @objc(removeTodos:)
  @NSManaged public func removeFromTodos(_ values: Set<ToDo>)
  
}
