//
//  TodoListEditView.swift
//  NextUp
//
//  Created by Nate Koch on 8/14/21.
//

import SwiftUI

struct TodoListEditView: View {
    // MARK: View
    var body: some View {
        Form {
            Section(header: Text("Edit To Do List Name")) {
                TextField("Todo List Name", text: $viewModel.name).accessibility(label: Text("Change To Do List Name"))
            }
            Section(header: Text("Change To Do List Color")) {
                ColorPicker("To Do List Color", selection: $viewModel.color, supportsOpacity: false)
            }
        }.accessibility(label: Text("Edit To Do List Form"))
        .navigationBarTitle("Edit To Do List")
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
    
    // MARK: Action
    private func saveButton() -> some View {
        Button(action: {
            viewModel.saveChanges()
            isPresented = false
            shouldNavigateToEditTodoList = true
        }, label: {
            Text("Save")
        }).disabled(!viewModel.canSave).accessibilityElement()
        .accessibilityIdentifier("Save Changes For To Do List Button")
        .accessibilityLabel("Save Changes For To Do List")
        .accessibility(addTraits: .isButton)
    }
    
    // MARK: Initialization
    init(isPresented: Binding<Bool>, viewModel: TodoListEditViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }
    
    // MARK: Properties
    @State private var shouldNavigateToEditTodoList = false
    
    @Binding private var isPresented: Bool
    
    @ObservedObject private var viewModel: TodoListEditViewModel
}

// MARK: Preview
struct TodoListEditView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", orderIndex: 0, context: Injector.shared.persistentContainer.viewContext)
        
        return
            Injector.shared.viewFactory.todoListEditView(isPresented: $isPresented, todoList: todoList)
    }
}

