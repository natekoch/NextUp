//
//  TodoListAddViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import Foundation
import CoreData
import CoreGraphics


class TodoListAddViewModel : NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    // MARK: Action
    func saveChanges() {
        guard canSave else {
            return
        }
        
        taskRepository.addTodoList(withName: name, withColor: color)
        
        taskViewModel.updateCurrentTodoList()
        taskViewModel.updateCurrentTask()
    }
    
    // MARK: NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    // MARK: Initialization
    init(taskRepository: TaskRepository, viewFactory: ViewFactory, taskViewModel: TaskViewModel) {
        self.taskRepository = taskRepository
        self.viewFactory = viewFactory
        self.name = ""
        self.color = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        self.taskViewModel = taskViewModel
        super.init()
        
        resultsController = self.taskRepository.todoListResultsController(with: self)
    }
    
    @Published var name: String
    @Published var color: CGColor
    
    let viewFactory: ViewFactory
    private let taskRepository: TaskRepository
    private let taskViewModel: TaskViewModel
    
    var resultsController: NSFetchedResultsController<TodoList>? = nil

    var todoLists: Array<TodoList> {
        resultsController?.fetchedObjects ?? []
    }
    
    var canSave: Bool {
        name != ""
    }
}
