//
//  ToDo+CoreDataProperties.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/22/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData


extension ToDo {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var todo: String
    @NSManaged public var completedTodo: Bool
    @NSManaged public var goal: Goal?
}
