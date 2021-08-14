//
//  SettingsViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/14/21.
//

import Foundation
import CoreData


class SettingsViewModel : NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    func deleteTodoList(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }

        let todoList = todoLists[index]
        self.taskRepository.delete(todoList)
    }
    
    // MARK: NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    
    // MARK: Initialization
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        super.init()

        resultsController = self.taskRepository.todoListResultsController(with: self)
    }
    
    var resultsController: NSFetchedResultsController<TodoList>? = nil
    
    var todoLists: Array<TodoList> {
        resultsController?.fetchedObjects ?? []
    }
    
    private let taskRepository: TaskRepository
}
