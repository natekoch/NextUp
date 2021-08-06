//
//  Injector.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//

import CoreData
import Foundation

class Injector {
    private init() {
        let bundle = Bundle(for: Task.self)
        let modelURL = bundle.url(forResource: "Model", withExtension: "momd")!
        managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        //taskRepository = TaskService()
        persistentContainer = NSPersistentContainer(name: "Model", managedObjectModel: self.managedObjectModel)
        //viewFactory = ViewFactory(taskRepository: self.taskRepository)
    }
    
    let managedObjectModel: NSManagedObjectModel
    
    static let shared = Injector()
    
    //let viewFactory: ViewFactory
    
    let persistentContainer: NSPersistentContainer
    
    //let taskRepository: TaskRepository
    
}
