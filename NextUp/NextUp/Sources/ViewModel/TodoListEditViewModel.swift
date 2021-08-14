//
//  TodoListEditViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/14/21.
//

import Foundation
import CoreData
import CoreGraphics


class TodoListEditViewModel : ObservableObject {
    // MARK: Action
    func saveChanges() {
        guard canSave else {
            return
        }

        todoList.name = name
        todoList.redValue = Float(color.components?[0] ?? 0)
        todoList.greenValue = Float(color.components?[1] ?? 0)
        todoList.blueValue = Float(color.components?[2] ?? 0)
    }
    
    // MARK: Initialization
    init(todoList: TodoList) {
        self.todoList = todoList
        self.name = todoList.name
        self.color = CGColor(red: CGFloat(todoList.redValue), green: CGFloat(todoList.greenValue), blue: CGFloat(todoList.blueValue), alpha: 100)
    }
    
    let todoList: TodoList
    
    @Published var name: String
    @Published var color: CGColor
    
    var canSave: Bool {
        name != ""
    }
}
