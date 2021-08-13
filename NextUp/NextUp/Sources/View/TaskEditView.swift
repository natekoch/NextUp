//
//  TaskEditView.swift
//  NextUp
//
//  Created by Nate Koch on 8/6/21.
//

import SwiftUI


struct TaskEditView: View {
    var body: some View {
        Form {
            Section(header: Text("Edit Task Name")) {
                TextField("Current Task Name", text: $viewModel.name)
                    .accessibility(label: Text("Change Task Name"))
            }
            Section(header: Text("Choose Due Date")) {
                Toggle("Enable Due Date", isOn: $viewModel.dateEnabled)
                    .accessibility(label: Text("Toggle Due Date"))
                DatePicker("Due Date", selection: $viewModel.date)
                    .accessibility(label: Text("Change Due Date"))
                    .disabled(!viewModel.dateEnabled)
            }
            Section(header: Text("Display Weather?")) {
                Toggle("Display Weather", isOn: $viewModel.weatherEnabled)
                    .accessibility(label: Text("Toggle Weather"))
            }
        }.accessibilityLabel("Edit Task Form")
        .navigationBarTitle("Edit Task")
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
    
    @State private var newName: String = ""
    @State private var isToggledDate: Bool = false
    @State private var newDate: Date = Date()
    @State private var isToggledWeather: Bool = false
    
    
    private func saveButton() -> some View {
        Button(action: {
            viewModel.saveChanges()

            isPresented = false
        }, label: {
            Text("Save")
        }).disabled(!viewModel.canSave)
    }
    
    init(isPresented: Binding<Bool>, viewModel: EditTaskViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: EditTaskViewModel
    
}

struct TaskEditView_Previews: PreviewProvider {
    @State static var isPresented = true

    static var previews: some View {
        let todoList = TodoList(color: "red", name: "Test TodoList", context: Injector.shared.persistentContainer.viewContext)

        let task = Task(date: nil, name: "Example Task", orderIndex: 1, weatherEnabled: true, todoList: todoList, context: Injector.shared.persistentContainer.viewContext)

        return NavigationView {
            TaskEditView(isPresented: $isPresented, viewModel: EditTaskViewModel(task: task, taskRepository: Injector.shared.taskRepository))
        }
    }
}
