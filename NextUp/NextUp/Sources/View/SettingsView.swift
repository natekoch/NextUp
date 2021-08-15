//
//  SettingsView.swift
//  NextUp
//
//  Created by Nate Koch on 8/4/21.
//

import UserNotifications
import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            NavigationLink(
                destination: viewFactory.todoListAddView(isPresented: $shouldNavigateToAddTodoList),
                isActive: $shouldNavigateToAddTodoList,
                label: {}).hidden()
            VStack {
                List {
                    ForEach(viewModel.todoLists) {
                        todoList in
                        NavigationLink(
                            destination: viewFactory.todoListEditView(isPresented: $shouldNavigateToEditTodoList, todoList: todoList),
                            label: {
                                Text(todoList.name)
                            })
                    }.onDelete(perform: { indexSet in
                        viewModel.deleteTodoList(at: indexSet)})
                    .onMove(perform: onMove)
                    .onLongPressGesture {
                        withAnimation {
                            self.isEditable = true
                        }
                    }
                }.environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
                Button("Notifications Permission") {
                    UNUserNotificationCenter.current()
                        .requestAuthorization(options: [.alert, .badge, .sound]) {
                            success, error in
                            if success {
                                print("Notifcations Enabled")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                }
            }
        }.navigationBarTitle("Settings")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }

            // This prevents a bug that causes the back button to disappear, based on: https://stackoverflow.com/a/67838069/2666110
            ToolbarItem(placement: .navigationBarLeading) {
                Color.clear.hidden()
            }
        })
    }
        
    private func onMove(source: IndexSet, destination: Int) {
        viewModel.move(fromOffsets: source, toOffset: destination)
        
        //https://stackoverflow.com/a/57737959/15939278
        withAnimation {
            isEditable = false
        }
    }
    
    private func addButton() -> some View {
        Button(action: {
            shouldNavigateToAddTodoList = true
        }, label: {
            Image(systemName: "plus.square.fill").imageScale(.large)
        })
    }
    
    
    init(viewModel: SettingsViewModel, viewFactory: ViewFactory) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
    }
    
    @State private var shouldNavigateToEditTodoList = false
    @State private var shouldNavigateToAddTodoList = false
    
    @State private var isEditable = false
    
    @ObservedObject private var viewModel: SettingsViewModel
    
    private let viewFactory: ViewFactory
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Injector.shared.viewFactory.settingsView()
        }
    }
}

