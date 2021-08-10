//
//  Task+CoreDataProperties.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String
    @NSManaged public var orderIndex: Int64
    @NSManaged public var weatherEnabled: Bool
    @NSManaged public var todoList: TodoList

}

extension Task : Identifiable {

}
