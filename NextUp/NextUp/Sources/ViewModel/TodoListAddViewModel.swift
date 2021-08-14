//
//  TodoListAddViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import Foundation
import CoreGraphics


class TodoListAddViewModel : ObservableObject {
    // MARK: Action
    func saveChanges() {
        guard canSave else {
            return
        }
        
        taskRepository.addTodoList(withName: name, withColor: color)
    }
    
    // MARK: Initialization
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        self.name = ""
        self.color = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
    }
    
    @Published var name: String
    @Published var color: CGColor
    
    private let taskRepository: TaskRepository
    
    var canSave: Bool {
        name != ""
    }
}
