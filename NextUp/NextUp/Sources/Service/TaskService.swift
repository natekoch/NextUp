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


class TaskService : TaskRepository {
    
    func addTodoList(withName name: String, withColor color: String) {
        _ = TodoList(color: color, name: name, context: persistentContainer.viewContext)
        
        saveViewContext()
    }
    
    func addTask(to todoList: TodoList, name: String, date: Date?, weatherEnabled: Bool) {
        _ = Task(date: date, name: name, orderIndex: Int64(todoList.tasks?.count ?? 0), weatherEnabled: weatherEnabled, todoList: todoList, context: persistentContainer.viewContext)
        
        saveViewContext()
    }
    
    func delete(_ todoList: TodoList) {
        persistentContainer.viewContext.delete(todoList)
        
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
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TodoList.name, ascending: true)]

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
        persistentContainer = NSPersistentContainer(name: "Model")
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        })
    }
    
    // MARK: Properties
    private let persistentContainer: NSPersistentContainer
}
