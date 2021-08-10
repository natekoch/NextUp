//
//  TaskView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI
import CoreData

struct TaskView: View {
    // MARK: View
    var body: some View {
        VStack {
            Spacer()
            Text("Next Up:")
                .bold()
                .font(.system(size: 20))
            Text(task.name)
                .bold()
                .padding(.top)
                .font(.system(size: 30))
            Text(displayDateString)
                .padding(.top)
            HStack {
                Image(systemName: "cloud.sun.rain").padding(.vertical)
                Text("78*").padding(.vertical)
            }
            Button(action: {}, label: {
                Text("Complete").bold()
            })
            .padding(.bottom)
            .font(.system(size: 20))
            Button(action: {}, label: {
                Text("Skip")
            })
            
            Spacer()
        }.navigationTitle(task.todoList.name)
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    Text("")
                        .frame(width: 0, height: 0)
                        .accessibilityHidden(true)
                    Button(action: {}, label: {
                        Image(systemName: "list.dash")
                            .font(Font.body)
                            .imageScale(.large)
                    }).accessibilityElement()
                    .accessibilityIdentifier("Show Todo Lists Button")
                    .accessibilityLabel("Show Todo Lists")
                    .accessibility(addTraits: .isButton)
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {}, label: {
                    Image(systemName: "gearshape")
                        .font(Font.body)
                        .imageScale(.large)
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Edit")
                })
            }
        })
    }
    
    
    // MARK: Initialization
    init(task: Task, viewFactory: ViewFactory, taskRepository: TaskRepository) {
        self.task = task
        self.viewFactory = viewFactory
        self.taskRepository = taskRepository
        
        self.dateFormatter.locale = Locale(identifier: "en_US")
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .medium
        
        if let displayDate = task.date {
            self.displayDateString = self.dateFormatter.string(from: displayDate)
        } else {
            self.displayDateString = ""
        }
        
        
    }
    
    // MARK: Properties
    private let task: Task
    private let viewFactory: ViewFactory
    private let taskRepository: TaskRepository
    private let displayDateString: String
    private let dateFormatter: DateFormatter = DateFormatter()
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        //Injector.shared.viewFactory
        let taskRepository = TaskService()
        let context = NSPersistentContainer(name: "Preview Model").viewContext
        
        TaskView(task: Task(date: Date(), name: "Preview Task", orderIndex: 0, weatherEnabled: false, todoList: TodoList(color: "red", name: "Home", context: context), context: context), viewFactory: ViewFactory(taskRepository: taskRepository), taskRepository: taskRepository)
    }
}
