//
//  TodoList+CoreDataClass.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//
//

import Foundation
import CoreData

@objc(TodoList)
public class TodoList: NSManagedObject {
    convenience init(color: String?, name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.color = color
        self.name = name
    }
}
