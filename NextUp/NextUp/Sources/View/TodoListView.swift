//
//  TodoListView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct TodoListView: View {
    var body: some View {
        // MARK: View
        ZStack {
            // Add Task Navigate
            NavigationLink(
                destination: viewFactory.taskAddView(isPresented: $shouldNavigateToAddTask, todoList: viewModel.todoList),
                isActive: $shouldNavigateToAddTask,
                label: {}).hidden()
            
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(destination: viewFactory.taskEditView(isPresented: $shouldNavigateToEditTask, task: task)) {
                        HStack {
                            VStack{
                                Text(task.name)
                            }
                        }.padding(.horizontal)
                    }
                }.onDelete(perform: { indexSet in
                    viewModel.deleteTask(at: indexSet)
                })
                .onMove(perform: onMove)
                .onLongPressGesture {
                    withAnimation {
                        self.isEditable = true
                    }
                }
                .accessibilityLabel("List of Tasks in Current To Do List")
            }.environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
        }.navigationBarTitle(viewModel.todoList.name)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }

            // This prevents a bug that causes the back button to disappear, based on: https://stackoverflow.com/a/67838069/2666110
            ToolbarItem(placement: .navigationBarLeading) {
                Color.clear.hidden()
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button(action: {
                    viewModel.randomizeOrder()
                }, label: {
                    Text("Randomize")
                }).accessibilityElement()
                .accessibilityIdentifier("Randomize Button")
                .accessibilityLabel("Randomize Order")
                .accessibility(addTraits: .isButton)
            }
        })
    }
    
    // MARK: Actions
    private func onMove(source: IndexSet, destination: Int) {
        viewModel.move(fromOffsets: source, toOffset: destination)
        //https://stackoverflow.com/a/57737959/15939278
        withAnimation {
            isEditable = false
        }
    }
    
    private func addButton() -> some View {
        Button(action: {
            shouldNavigateToAddTask = true
        }, label: {
            Image(systemName: "plus.square.fill")
        }).accessibilityElement()
        .accessibilityIdentifier("Add New Task Button")
        .accessibilityLabel("Add New Task")
        .accessibility(addTraits: .isButton)
    }
    
    // MARK: Initialization
    init(viewModel: TodoListViewModel, viewFactory: ViewFactory) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
    }

    // MARK: Properties
    @State private var shouldNavigateToEditTask = false
    @State private var shouldNavigateToAddTask = false
    @State private var isEditable = false
    
    @ObservedObject private var viewModel: TodoListViewModel
    
    private let viewFactory: ViewFactory
}

// MARK: Preview
struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", orderIndex: 0, context: Injector.shared.persistentContainer.viewContext)
        
        let _ = Task(date: nil, name: "Example Task 1", orderIndex: 0, weatherEnabled: true, todoList: todoList, dateEnabled: true, context: Injector.shared.persistentContainer.viewContext)
        

        let _ = Task(date: Date(), name: "Example Task 2", orderIndex: 1, weatherEnabled: true, todoList: todoList, dateEnabled: false, context: Injector.shared.persistentContainer.viewContext)
        
        let _ = Task(date: nil, name: "Example Task 3", orderIndex: 2, weatherEnabled: true, todoList: todoList, dateEnabled: true, context: Injector.shared.persistentContainer.viewContext)
        
        NavigationView {
            Injector.shared.viewFactory.todoListView(todoList: todoList)
        }
    }
}

