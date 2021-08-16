//
//  TodoListAddView.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import SwiftUI

struct TodoListAddView: View {
    // MARK: View
    var body: some View {
        Form {
            Section(header: Text("Add To Do List Name")) {
                TextField("To Do List Name", text: $viewModel.name).accessibility(label: Text("Add To Do List Name"))
                    .accessibilityIdentifier("To Do List Name TextField")
                    .accessibilityLabel("To Do List Name")
            }
            Section(header: Text("Choose To Do List Color")) {
                ColorPicker("To Do List Color", selection: $viewModel.color, supportsOpacity: false)
                    .accessibilityIdentifier("To Do List Color Color Picker")
                    .accessibilityLabel("To Do List Color")
            }
        }.accessibility(label: Text("Add New To Do List Form"))
        .navigationBarTitle("Add New To Do List")
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
        }, label: {
            Text("Save")
        }).disabled(!viewModel.canSave)
        .accessibilityElement()
        .accessibilityIdentifier("Save New To Do List Button")
        .accessibilityLabel("Save New To Do List")
        .accessibility(addTraits: .isButton)
    }
    
    // MARK: Initialization
    init(isPresented: Binding<Bool>, viewModel: TodoListAddViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }
    
    // MARK: Properties
    @Binding private var isPresented: Bool
    
    @ObservedObject private var viewModel: TodoListAddViewModel
}

// MARK: Preview
struct TodoListAddView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        Injector.shared.viewFactory.todoListAddView(isPresented: $isPresented)
    }
}
