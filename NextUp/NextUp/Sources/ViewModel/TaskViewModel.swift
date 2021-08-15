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
        if self.tasks.count != 0 {
            self.taskRepository.delete(self.tasks[0], from: self.currentTodoList!)
        }
        //if self.tasks.count != 0 {
            //self.currentTask = self.tasks[0]
        //}
    }
    
    func skipTask() {
        if self.tasks[0].orderIndex+1 != self.tasks.count {
            self.tasks[0].orderIndex += 1
            self.tasks[1].orderIndex -= 1
            
            //self.currentTask = self.tasks[0]
        }
        
        // TODO: probably want to go to new screen
    }
    
    func changeTodoList() {
        if self.todoLists[0].orderIndex+1 != self.todoLists.count {
            self.todoLists[self.todoLists.count-1].orderIndex = 0
            for index in 1...todoLists.count-1 {
                todoLists[index].orderIndex += 1
            }
            print("Current To Do List \(currentTask?.name ?? "no name change todolist")")
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
        //if self.todoLists.count != 0 {
            //self.currentTodoList = todoLists[0]
        if !noTodoLists {
            taskResultsController = self.taskRepository.taskResultsController(for: self.currentTodoList!, with: self)
        }
        
        //if self.tasks.count != 0 {
            //self.currentTask = tasks[0]
        //}
    }
 
    // MARK: Properties
    
    var currentTask: Task? {
        if tasks.count != 0 {
            return tasks[0]
        } else {
            return nil
        }
    }
    
    var currentTodoList: TodoList? {
        if todoLists.count != 0 {
            return todoLists[0]
        } else {
            return nil
        }
    }
    
    var todoListResultsController: NSFetchedResultsController<TodoList>? = nil
    
    var taskResultsController: NSFetchedResultsController<Task>? = nil
    
    var todoLists: Array<TodoList> {
        todoListResultsController?.fetchedObjects ?? []
    }
    
    var tasks: Array<Task> {
        taskResultsController?.fetchedObjects ?? []
    }
    
    var noTasks: Bool {
        tasks.count == 0
    }
    
    var noTodoLists: Bool {
        todoLists.count == 0
    }
    
    
    @Published var weather: String
    
    private let taskRepository: TaskRepository
}
