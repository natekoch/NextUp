//
//  AddTaskViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/7/21.
//

import Foundation
import SwiftUI

class AddTaskViewModel : ObservableObject {
    // MARK: Action
    func saveChanges() {
        guard canSave else {
            return
        }
        
        taskRepository.addTask(to: todoList, name: name, date: date, weatherEnabled: weatherEnabled, dateEnabled: dateEnabled)
    }
    
    
    // MARK: Initialization
    init(todoList: TodoList, taskRepository: TaskRepository) {
        self.todoList = todoList
        self.taskRepository = taskRepository
        self.name = ""
        self.date = Date()
        self.weatherEnabled = false
        self.dateEnabled = false
    }
    
    
    // MARK: Properties
    let todoList: TodoList
    
    @Published var name: String
    @Published var date: Date
    @Published var dateEnabled: Bool
    @Published var weatherEnabled: Bool
    private let taskRepository: TaskRepository
    
    var canSave: Bool {
        name != ""
    }
}
