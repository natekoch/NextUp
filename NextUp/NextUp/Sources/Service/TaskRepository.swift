//
//  TaskRepository.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//

import Foundation
import CoreData

protocol TaskRepository {
    func addTodoList(withName name: String)
    
    func addTask(to todoList: TodoList, name: String, date: Date?, weatherEnabled: Bool)
    
    func delete(_ todoList: TodoList)
    
    func delete(_ task: Task, from todoList: TodoList)
    
    func todoListResultsController(with delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<TodoList>?
    
    func taskResultsController(for todoList: TodoList, with delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<Task>?
}
