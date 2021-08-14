//
//  NoTasksView.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import SwiftUI

struct NoTodoListsView: View {
    var body: some View {
        ZStack {
            NavigationLink(
                destination: viewFactory.todoListAddView(isPresented: $shouldNavigateToAddTodoList),
                isActive: $shouldNavigateToAddTodoList,
                label: {}).hidden()
            
            VStack {
                Text("No todo lists...")
                Button(action: {
                    shouldNavigateToAddTodoList = true
                }, label: {
                    Text("Create New Todo List")
                })
            }
        }
    }
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    @State private var shouldNavigateToAddTodoList = false
    
    private let viewFactory: ViewFactory
}

struct NoTodoListsView_Previews: PreviewProvider {
    static var previews: some View {
        Injector.shared.viewFactory.noTodoListsView()
    }
}
