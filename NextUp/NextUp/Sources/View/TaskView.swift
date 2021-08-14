//
//  TaskView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI
import CoreData
import CoreGraphics

struct TaskView: View {
    // MARK: View
    var body: some View {
        ZStack {
            NavigationLink(
                destination: viewFactory.taskEditView(isPresented: $shouldNavigateToEditTask, task: viewModel.task),
                isActive: $shouldNavigateToEditTask,
                label: {}).hidden()
            
            NavigationLink(
                destination: viewFactory.taskView(isPresented: $shouldSkipTask, task: viewModel.task),
                isActive: $shouldSkipTask,
                label: {}).hidden()
            
            VStack {
                Spacer()
                Text("Next Up:")
                    .bold()
                    .font(.system(size: 20))
                Text(self.viewModel.task.name)
                    .bold()
                    .padding(.top)
                    .font(.system(size: 30))
                    .foregroundColor(self.color)
                Text(displayDateString)
                    .padding(.top)
                HStack {
                    Image(systemName: "cloud.sun.rain").padding(.vertical)
                    Text("78*").padding(.vertical)
                }
                Button(action: {
                    viewModel.completeTask()
                    // TODO: task completed bool
                }, label: {
                    Image(systemName: "checkmark.circle.fill").resizable().frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.green)
                        
                })
                .padding(.bottom)
                .font(.system(size: 20))
                Button(action: {
                    viewModel.skipTask()
                    // TODO: task skipped bool
                    shouldSkipTask = true
                }, label: {
                    Image(systemName: "arrow.right").resizable().frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                })
                
                Spacer()
            }
        }.navigationTitle(self.viewModel.task.todoList.name)
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
                            .foregroundColor(self.color)
                    }).accessibilityElement()
                    .accessibilityIdentifier("Show Todo Lists Button")
                    .accessibilityLabel("Show Todo Lists")
                    .accessibility(addTraits: .isButton)
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gearshape")
                        .font(Font.body)
                        .imageScale(.large)
                        .accentColor(.red)
                })
                Spacer()
                Button(action: {
                    shouldNavigateToEditTask = true
                }, label: {
                    Text("Edit")
                })
            }
        })
    }
    
    
    // MARK: Initialization
    init(isPresented: Binding<Bool>, viewModel: TaskViewModel, viewFactory: ViewFactory) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        self.viewFactory = viewFactory
        
        self.dateFormatter.locale = Locale(identifier: "en_US")
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .short
        
        if let displayDate = viewModel.task.date {
            self.displayDateString = self.dateFormatter.string(from: displayDate)
        } else {
            self.displayDateString = ""
        }
        
        self.color = Color(.sRGB, red: Double(viewModel.task.todoList.redValue), green: Double(viewModel.task.todoList.greenValue), blue: Double(viewModel.task.todoList.blueValue), opacity: 100)
    }
    
    // MARK: Properties
    @State private var shouldNavigateToEditTask = false
    @State private var shouldSkipTask = false
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: TaskViewModel
    
    private let viewFactory: ViewFactory
    private let displayDateString: String
    private let dateFormatter: DateFormatter = DateFormatter()
    
    private let color: Color
}

struct TaskView_Previews: PreviewProvider {
    @State static var isPresented = false

    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", context: Injector.shared.persistentContainer.viewContext)
        
        let task = Task(date: Date(), name: "Preview Task", orderIndex: 0, weatherEnabled: false, todoList: todoList, context: Injector.shared.persistentContainer.viewContext)
        return NavigationView {
            Injector.shared.viewFactory.taskView(isPresented: $isPresented, task: task)
        }
    }
}

