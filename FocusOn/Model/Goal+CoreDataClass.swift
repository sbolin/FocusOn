//
//  Goal+CoreDataClass.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/22/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//
//

import Foundation
import CoreData


public class Goal: NSManagedObject {
  
  var latestToDo: ToDo? {
    guard let todos = todos,
      let startingToDo = todos.first
      else {
        return nil
    }
    return Array(todos).reduce(startingToDo) {
      $0.dateCreated.compare($1.dateCreated) == .orderedAscending ? $0 : $1
    }
  }
  
  public override func awakeFromInsert() {
    super.awakeFromInsert()
    dateCreated = Date()
  }
}
