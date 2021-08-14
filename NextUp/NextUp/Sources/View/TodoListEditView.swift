//
//  TodoListEditView.swift
//  NextUp
//
//  Created by Nate Koch on 8/14/21.
//

import SwiftUI

struct TodoListEditView: View {
    var body: some View {
        /*NavigationLink(
            destination: viewModel.viewFactory.todoListView(todoList: viewModel.todoLists[viewModel.todoLists.count-1]),
            isActive: $shouldNavigateToEditTodoList,
            label: {}).hidden()
          */
        Form {
            Section(header: Text("Edit Todo List Name")) {
                TextField("Todo List Name", text: $viewModel.name).accessibility(label: Text("Change Todo List Name"))
            }
            Section(header: Text("Change Todo List Color")) {
                ColorPicker("Todo List Color", selection: $viewModel.color, supportsOpacity: false)
            }
        }.accessibility(label: Text("Edit Todo List Form"))
        .navigationBarTitle("Edit Todo List")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                saveButton()
            }

            // This prevents a bug that causes the back button to disappear, based on: https://stackoverflow.com/a/67838069/2666110
            ToolbarItem(placement: .navigationBarLeading) {
                Color.clear.hidden()
            }
        })
    }
    
    private func saveButton() -> some View {
        Button(action: {
            viewModel.saveChanges()
            isPresented = false
            shouldNavigateToEditTodoList = true
        }, label: {
            Text("Save")
        }).disabled(!viewModel.canSave)
    }
    
    //use view model instead of task repo
    init(isPresented: Binding<Bool>, viewModel: TodoListEditViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }
    
    @State private var shouldNavigateToEditTodoList = false
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: TodoListEditViewModel
}
/*
struct TodoListEditView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        //Injector.shared.viewFactory.todoListEditView(todoList: )
    }
}
*/
