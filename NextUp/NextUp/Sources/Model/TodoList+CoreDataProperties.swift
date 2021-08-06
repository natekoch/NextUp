//
//  TodoList+CoreDataProperties.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension TodoList {

    @objc(addTasksObject:)
    @NSManaged func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged func removeFromTasks(_ values: NSSet)

}

extension TodoList : Identifiable {

}
