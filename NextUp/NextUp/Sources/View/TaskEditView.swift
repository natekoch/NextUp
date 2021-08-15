//
//  TaskEditView.swift
//  NextUp
//
//  Created by Nate Koch on 8/6/21.
//

import SwiftUI
import CoreGraphics

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
        .foregroundColor(self.color)
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
        
        self.color = Color(.sRGB, red: Double(viewModel.task.todoList.redValue), green: Double(viewModel.task.todoList.greenValue), blue: Double(viewModel.task.todoList.blueValue), opacity: 100)
    }
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: EditTaskViewModel
    
    private let color: Color
}

struct TaskEditView_Previews: PreviewProvider {
    @State static var isPresented = true

    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", orderIndex: 0, context: Injector.shared.persistentContainer.viewContext)

        let task = Task(date: nil, name: "Example Task", orderIndex: 1, weatherEnabled: true, todoList: todoList, dateEnabled: true, context: Injector.shared.persistentContainer.viewContext)

        return NavigationView {
            TaskEditView(isPresented: $isPresented, viewModel: EditTaskViewModel(task: task, taskRepository: Injector.shared.taskRepository))
        }
    }
}
