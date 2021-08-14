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
    
    func todoListView(todoList: TodoList) -> TodoListView {
        TodoListView(viewModel: TodoListViewModel(todoList: todoList, taskRepository: self.taskRepository), viewFactory: self)
    }
    
    func taskView(isPresented: Binding<Bool>, task: Task) -> TaskView {
        TaskView(isPresented: isPresented, viewModel: TaskViewModel(task: task, taskRepository: self.taskRepository), viewFactory: self)
    }
    
    func todoListAddView(isPresented: Binding<Bool>) -> TodoListAddView {
        TodoListAddView(isPresented: isPresented, viewModel: TodoListAddViewModel(taskRepository: self.taskRepository, viewFactory: self))
    }
    
    func todoListEditView(isPresented: Binding<Bool>, todoList: TodoList) -> TodoListEditView {
        TodoListEditView(isPresented: isPresented, viewModel: TodoListEditViewModel(todoList: todoList))
    }
    
    func settingsView() -> SettingsView {
        SettingsView(viewModel: SettingsViewModel(taskRepository: self.taskRepository), viewFactory: self)
    }
    
    func noTodoListsView() -> NoTodoListsView {
        NoTodoListsView(viewFactory: self)
    }
    
    func rootView() -> RootView {
        RootView(viewFactory: self)
    }
    
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    private let taskRepository: TaskRepository
}
