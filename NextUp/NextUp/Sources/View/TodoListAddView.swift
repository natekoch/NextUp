//
//  TodoListAddView.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import SwiftUI

struct TodoListAddView: View {
    var body: some View {
        Form {
            Section(header: Text("Add Todo List Name")) {
                TextField("Todo List Name", text: $viewModel.name).accessibility(label: Text("Add Todo List Name"))
            }
            Section(header: Text("Choose Todo List Color")) {
                ColorPicker("Todo List Color", selection: $viewModel.color, supportsOpacity: false)
            }
        }.accessibility(label: Text("Add New Todo List Form"))
        .navigationBarTitle("Add New Todo List")
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
        }, label: {
            Text("Save")
        }).disabled(!viewModel.canSave)
    }
    
    //use view model instead of task repo
    init(isPresented: Binding<Bool>, viewModel: TodoListAddViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: TodoListAddViewModel
}

struct TodoListAddView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        Injector.shared.viewFactory.todoListAddView(isPresented: $isPresented)
    }
}
