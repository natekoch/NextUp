//
//  TaskService.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//

import Foundation
import Combine
import CoreData
import OSLog
import CoreGraphics


class TaskService : TaskRepository {
    
    func addTodoList(withName name: String, withColor color: CGColor) {
        let redValue = Float(color.components?[0] ?? 0.0)
        let greenValue = Float(color.components?[1] ?? 0.0)
        let blueValue = Float(color.components?[2] ?? 0.0)
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let todoLists = (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        _ = TodoList(redValue: redValue, greenValue: greenValue, blueValue: blueValue, name: name, orderIndex: Int64(todoLists.count),context: persistentContainer.viewContext)
        
        saveViewContext()
    }
    
    func addTask(to todoList: TodoList, name: String, date: Date?, weatherEnabled: Bool) {
        _ = Task(date: date, name: name, orderIndex: Int64(todoList.tasks?.count ?? 0), weatherEnabled: weatherEnabled, todoList: todoList, context: persistentContainer.viewContext)
        
        saveViewContext()
    }
    
    func delete(_ todoList: TodoList) {
        persistentContainer.viewContext.delete(todoList)
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "orderIndex > %@", todoList.orderIndex as NSNumber, todoList)
        let results = (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        for todoListToAdjust in results {
            todoListToAdjust.orderIndex -= 1
        }
        
        saveViewContext()
    }
    
    func delete(_ task: Task, from todoList: TodoList) {
        persistentContainer.viewContext.delete(task)
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "orderIndex > %@ AND todoList == %@", task.orderIndex as NSNumber, todoList)
        let results = (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        for taskToAdjust in results {
            taskToAdjust.orderIndex -= 1
        }
        
        saveViewContext()
    }
    
    private func saveViewContext() {
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            Logger.shared.error("Failed to save viewContext, rolling back")
            persistentContainer.viewContext.rollback()
        }
    }
    
    func todoListResultsController(with delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<TodoList>? {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TodoList.orderIndex, ascending: true)]

        return createResultsController(for: delegate, fetchRequest: fetchRequest)
    }
    
    func taskResultsController(for todoList: TodoList, with delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Task>? {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "todoList == %@", todoList)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Task.orderIndex, ascending: true)]

        return createResultsController(for: delegate, fetchRequest: fetchRequest)
    }
    
    
    private func createResultsController<T>(for delegate: NSFetchedResultsControllerDelegate, fetchRequest: NSFetchRequest<T>) -> NSFetchedResultsController<T>? where T: NSFetchRequestResult {
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        resultsController.delegate = delegate

        guard let _ = try? resultsController.performFetch() else {
            return nil
        }

        return resultsController
    }
    
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NextUp")
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        })
    }
    
    // MARK: Properties
    let persistentContainer: NSPersistentContainer
    
    static let shared = TaskService()
}
