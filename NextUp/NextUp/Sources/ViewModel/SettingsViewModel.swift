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
    
    // https://stackoverflow.com/a/62239979/15939278
    func move(fromOffsets: IndexSet, toOffset: Int) {
        var revisedTodoLists: [ TodoList ] = todoLists.map { $0 }
        
        revisedTodoLists.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        for reverseIndex in stride(from: revisedTodoLists.count-1,
                                   through: 0,
                                   by: -1) {
            revisedTodoLists[reverseIndex].orderIndex = Int64(reverseIndex)
        }
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
    
    // MARK: Properties
    var resultsController: NSFetchedResultsController<TodoList>? = nil
    
    var todoLists: Array<TodoList> {
        resultsController?.fetchedObjects ?? []
    }
    
    private let taskRepository: TaskRepository
}
