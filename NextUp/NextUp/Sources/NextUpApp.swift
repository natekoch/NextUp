//
//  NextUpApp.swift
//  NextUp
//
//  Created by Nate Koch on 8/2/21.
//

import SwiftUI

@main
struct NextUpApp: App {
    @State static var isPresented = true
    //var body: some Scene {
        //WindowGroup {
    let todoList = TodoList(color: "red", name: "Test TodoList", context: Injector.shared.persistentContainer.viewContext)

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TaskAddView(isPresented: NextUpApp.$isPresented, viewModel: AddTaskViewModel(todoList: todoList, taskRepository: Injector.shared.taskRepository))
            }
        }
    }
}
