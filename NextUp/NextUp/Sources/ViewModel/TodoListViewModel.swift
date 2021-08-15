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

    func randomizeOrder() {
        var indexes: Array<Int> = []
        var randomIndex = 0
        if tasks.count != 0 || tasks.count != 1 {
            for i in 0..<tasks.count {
                indexes.append(i)
            }
            for task in tasks {
                randomIndex = indexes.randomElement() ?? 0
                task.orderIndex = Int64(randomIndex)
                indexes.remove(at: indexes.firstIndex(of: randomIndex) ?? 0)
            }
        }
    }
    
    // https://stackoverflow.com/a/62239979/15939278
    func move(fromOffsets: IndexSet, toOffset: Int) {
        var revisedTasks: [ Task ] = tasks.map { $0 }
        
        revisedTasks.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        for reverseIndex in stride(from: revisedTasks.count-1,
                                   through: 0,
                                   by: -1) {
            revisedTasks[reverseIndex].orderIndex = Int64(reverseIndex)
        }
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
