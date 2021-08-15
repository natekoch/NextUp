//
//  TaskViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import Foundation
import SwiftUI
import CoreData

class TaskViewModel : NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    // MARK: Actions
    func completeTask() {
        if !self.tasks.isEmpty {
            self.taskRepository.delete(self.tasks[0], from: self.currentTodoList!)
        }
    }
    
    func skipTask() {
        if !self.tasks.isEmpty && self.tasks[0].orderIndex+1 != self.tasks.count {
            self.tasks[0].orderIndex += 1
            self.tasks[1].orderIndex -= 1
        }
    }
    
    func changeTodoList() {
        if !todoLists.isEmpty && todoLists.count != 1 {
            todoLists[0].orderIndex = Int64(todoLists.count)
            for index in 0..<todoLists.count {
                todoLists[index].orderIndex -= 1
            }
            print("Current To Do List \(currentTodoList?.name ?? "no name change todolist")")
        }
    }
    
    // MARK: NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    // MARK: Initialization
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        self.weather = "Weather"
        super.init()
        
        //todoListResultsController = self.taskRepository.todoListResultsController(with: self)
        
        //if !noTodoLists {
            //askResultsController = self.taskRepository.taskResultsController(for: self.currentTodoList!, with: self)
       //}
    }
 
    // MARK: Properties
    
    var currentTask: Task? {
        if !noTasks {
            return tasks[0]
        } else {
            return nil
        }
    }
    
    var currentTodoList: TodoList? {
        if !noTodoLists {
            return todoLists[0]
        } else {
            return nil
        }
    }
    
    var todoListResultsController: NSFetchedResultsController<TodoList>? {
        self.taskRepository.todoListResultsController(with: self)
    }
    
    var taskResultsController: NSFetchedResultsController<Task>? {
        if !noTodoLists {
            return self.taskRepository.taskResultsController(for: self.currentTodoList!, with: self)
        } else {
            return nil
        }
    }
    
    var todoLists: Array<TodoList> {
        todoListResultsController?.fetchedObjects ?? []
    }
    
    var tasks: Array<Task> {
        taskResultsController?.fetchedObjects ?? []
    }
    
    var noTasks: Bool {
        get {
            tasks.isEmpty
        }
        set {
        }
    }
    
    var noTodoLists: Bool {
        get {
            todoLists.count == 0
        }
        set {
        }
    }
    
    
    @Published var weather: String
    
    private let taskRepository: TaskRepository
}
