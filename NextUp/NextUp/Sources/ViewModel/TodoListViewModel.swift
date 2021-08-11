//
//  TodoListViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/10/21.
//

import CoreData
import Foundation


class TodoListViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    // MARK: Actions
    func deleteTask(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }

        let task = tasks[index]
        self.taskRepository.delete(task, from: self.todoList)
    }

    // MARK: NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }

    // MARK: Initialization
    init(todoList: TodoList, taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        self.todoList = todoList
        super.init()

        resultsController = self.taskRepository.taskResultsController(for: todoList, with: self)
    }

    // MARK: Properties
    var todoList: TodoList
    
    var resultsController: NSFetchedResultsController<Task>? = nil

    var tasks: Array<Task> {
        resultsController?.fetchedObjects ?? []
    }
    
    private let taskRepository: TaskRepository
}
