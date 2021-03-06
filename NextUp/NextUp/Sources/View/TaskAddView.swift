//
//  TaskEditView.swift
//  NextUp
//
//  Created by Nate Koch on 8/4/21.
//

import SwiftUI
import CoreGraphics

struct TaskAddView: View {
    var body: some View {
        // MARK: Actions
        VStack(alignment: .leading){
            Text("To Do List: \(viewModel.todoList.name)").bold().padding(.horizontal)
            Form {
                Section(header: Text("Add Task Name")) {
                    TextField("Task Name", text: $viewModel.name)
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
            }.accessibilityLabel("Add Task Form")
        }
        .foregroundColor(self.color)
        .navigationBarTitle("Add New Task")
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
        .accessibilityIdentifier("Save New Task Button")
        .accessibilityLabel("Save New Task")
        .accessibility(addTraits: .isButton)
    }
    
    // MARK: Initialization
    init(isPresented: Binding<Bool>, viewModel: AddTaskViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        
        self.color = Color(.sRGB, red: Double(viewModel.todoList.redValue), green: Double(viewModel.todoList.greenValue), blue: Double(viewModel.todoList.blueValue), opacity: 100)
    }
    
    // MARK: Properties
    @Binding private var isPresented: Bool
    
    @ObservedObject private var viewModel: AddTaskViewModel
    
    private let color: Color
}

// MARK: Preview
struct TaskAddView_Previews: PreviewProvider {
    @State static var isPresented = true

    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", orderIndex: 0, context: Injector.shared.persistentContainer.viewContext)

        return NavigationView {
            TaskAddView(isPresented: $isPresented, viewModel: AddTaskViewModel(todoList: todoList, taskRepository: Injector.shared.taskRepository, taskViewModel: TaskViewModel(taskRepository: Injector.shared.taskRepository)))
        }
    }
}
