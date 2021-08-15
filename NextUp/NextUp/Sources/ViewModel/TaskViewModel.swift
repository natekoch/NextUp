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
        self.taskRepository.delete(self.tasks[0], from: self.currentTodoList!)
        self.currentTask = self.tasks[0]
    }
    
    func skipTask() {
        if self.tasks[0].orderIndex+1 != self.tasks.count {
            self.tasks[0].orderIndex += 1
            self.tasks[1].orderIndex -= 1
            self.currentTask = self.tasks[1]
        }
        
        // TODO: probably want to go to new screen
    }
    
    func changeTodoList() {
        if self.todoLists[0].orderIndex+1 != self.todoLists.count {
            self.todoLists[0].orderIndex += 1
            self.todoLists[1].orderIndex -= 1
            self.currentTodoList = self.todoLists[0]
            self.taskResultsController = self.taskRepository.taskResultsController(for: self.currentTodoList!, with: self)
            print("Changed")
        }
    }
    
    // MARK: NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    // MARK: Initialization
    init(taskRepository: TaskRepository) {
        //self.task = task
        self.taskRepository = taskRepository
        self.weather = "Weather"
        super.init()
        
        todoListResultsController = self.taskRepository.todoListResultsController(with: self)
        
        self.currentTodoList = todoLists[0]
        
        taskResultsController = self.taskRepository.taskResultsController(for: self.currentTodoList!, with: self)
    
        self.currentTask = tasks[0]
    }
 
    // MARK: Properties
    var currentTask: Task? = nil
    
    var todoListResultsController: NSFetchedResultsController<TodoList>? = nil
    
    var taskResultsController: NSFetchedResultsController<Task>? = nil
    
    var todoLists: Array<TodoList> {
        todoListResultsController?.fetchedObjects ?? []
    }
    
    var tasks: Array<Task> {
        taskResultsController?.fetchedObjects ?? []
    }
    
    var currentTodoList: TodoList? = nil
    var currentTodoListIndex = 0
    
    @Published var weather: String
    
    private let taskRepository: TaskRepository
}
