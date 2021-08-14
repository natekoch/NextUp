//
//  TodoList+CoreDataProperties.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var redValue: Float
    @NSManaged public var name: String
    @NSManaged public var blueValue: Float
    @NSManaged public var greenValue: Float
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension TodoList {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension TodoList : Identifiable {

}
