//
//  NextUpApp.swift
//  NextUp
//
//  Created by Nate Koch on 8/2/21.
//

import SwiftUI

@main
struct NextUpApp: App {
    /*
    @State static var isPresented = true
    //var body: some Scene {
        //WindowGroup {
    let todoList = TodoList(redValue: 0.0, greenValue: 0.0, blueValue: 0.0, name: "Test TodoList", context: Injector.shared.persistentContainer.viewContext)
    */
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Injector.shared.viewFactory.noTodoListsView()
            }
        }
    }
}
