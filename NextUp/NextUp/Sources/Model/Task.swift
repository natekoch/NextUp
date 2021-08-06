//
//  Task+CoreDataClass.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//
//

import Foundation
import CoreData

class Task: NSManagedObject {
    convenience init(date: Date?, name: String?, orderIndex: Int64, weatherEnabled: Bool, todoList: TodoList?, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.date = date
        self.name = name
        self.orderIndex = orderIndex
        self.weatherEnabled = weatherEnabled
        self.todoList = todoList
    }
}
