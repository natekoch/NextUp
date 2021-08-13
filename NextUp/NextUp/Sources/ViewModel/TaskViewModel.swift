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
        self.taskRepository.delete(self.task, from: self.task.todoList)
        // TODO: new task screen
    }
    
    func skipTask() {
        if self.task.orderIndex+1 != self.tasks.count {
            self.task.orderIndex += 1
            self.tasks[Int(self.task.orderIndex+1)].orderIndex -= 1
            self.task = self.tasks[Int(self.task.orderIndex+1)]
        }
        
        // TODO: probably want to go to new screen
    }
    
    // MARK: NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    // MARK: Initialization
    init(task: Task, taskRepository: TaskRepository) {
        self.task = task
        self.taskRepository = taskRepository
        self.weather = "Weather"
        super.init()
        
        resultsController = self.taskRepository.taskResultsController(for: task.todoList, with: self)
    }
 
    // MARK: Properties
    var task: Task
    
    var resultsController: NSFetchedResultsController<Task>? = nil
    
    var tasks: Array<Task> {
        resultsController?.fetchedObjects ?? []
    }
    
    @Published var weather: String
    
    private let taskRepository: TaskRepository
}
