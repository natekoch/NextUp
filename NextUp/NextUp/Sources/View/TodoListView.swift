//
//  TodoListView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct TodoListView: View {
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(destination: viewFactory.taskEditView(task: task)) {
                        Text(task.name)
                    }
                }.onDelete(perform: { indexSet in
                    viewModel.deleteTask(at: indexSet)
                })
            }
        }.navigationTitle("Todo List Name")
        
    }
    
    // MARK: Initialization
    init(viewModel: TodoListViewModel, viewFactory: ViewFactory) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
    }

    // MARK: Properties
    @State private var shouldNavigateToAddTask = false
    @ObservedObject private var viewModel: TodoListViewModel
    private let viewFactory: ViewFactory
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
