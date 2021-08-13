//
//  ViewFactory.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//

import Foundation
import SwiftUI

class ViewFactory {
    func taskAddView(isPresented: Binding<Bool>, todoList: TodoList) -> TaskAddView {
        TaskAddView(isPresented: isPresented, viewModel: AddTaskViewModel(todoList: todoList, taskRepository: self.taskRepository))
    }
    
    func taskEditView(isPresented: Binding<Bool>, task: Task) -> TaskEditView {
        TaskEditView(isPresented: isPresented, viewModel: EditTaskViewModel(task: task, taskRepository: self.taskRepository))
    }
    
    func rootView() -> RootView {
        RootView(viewFactory: self)
    }
    
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    private let taskRepository: TaskRepository
}
