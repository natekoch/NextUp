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
                destination: viewFactory.todoListAddView(isPresented: $noTodoLists),
                isActive: $noTodoLists,
                label: {}).hidden()
            if (!noTodoLists) {
                NavigationLink(
                    destination: viewFactory.taskAddView(isPresented: $noTasks, todoList: viewModel.currentTodoList!),
                    isActive: $noTasks,
                    label: {}).hidden()
                
                NavigationLink(destination: viewFactory.todoListView(todoList: viewModel.currentTodoList!), isActive: $shouldNavigateToTodoList, label: {}).hidden()
                
                if (!noTasks) {
                    NavigationLink(
                        destination: viewFactory.taskEditView(isPresented: $shouldNavigateToEditTask, task: viewModel.currentTask!),
                        isActive: $shouldNavigateToEditTask,
                        label: {}).hidden()
                }
                
            }
            /*NavigationLink(
                destination: viewFactory.todoListAddView(isPresented: $shouldNavigateToAddTodoList),
                isActive: $shouldNavigateToAddTodoList,
                label: {}).hidden()
            
            NavigationLink(
                destination: viewFactory.taskAddView(isPresented: $viewModel.$shouldNavigateToAddTask, todoList: viewModel.currentTodoList!),
                isActive: $viewModel.$shouldNavigateToAddTask,
                label: {}).hidden()*/
            
            NavigationLink(
                destination: viewFactory.settingsView(),
                isActive: $shouldNavigateToSettings,
                label: {}).hidden()
           
            VStack {
                Spacer()
                Text("Next Up:")
                    .bold()
                    .font(.system(size: 20))
                if (!noTasks) {
                    Text(self.viewModel.currentTask!.name)
                        .bold()
                        .padding(.top)
                        .font(.system(size: 30))
                        .foregroundColor(self.color)
                }
                if (viewModel.currentTask!.dateEnabled) {
                    Text(displayDateString)
                        .padding(.top)
                }
                if (viewModel.currentTask!.weatherEnabled) {
                    HStack {
                        Image(systemName: "cloud.sun.rain").padding(.vertical)
                        Text("78*").padding(.vertical)
                    }
                }
                Button(action: {
                    viewModel.completeTask()
                }, label: {
                    Image(systemName: "checkmark.circle.fill").resizable().frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.green)
                        
                })
                .padding(.vertical)
                .font(.system(size: 20))
                Button(action: {
                    viewModel.skipTask()
                }, label: {
                    Image(systemName: "arrow.right").resizable().frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                })
                Spacer()
            }.gesture(drag)
        }.navigationTitle(self.viewModel.currentTodoList?.name ?? "No Name")
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    Text("")
                        .frame(width: 0, height: 0)
                        .accessibilityHidden(true)
                    Button(action: {
                        shouldNavigateToTodoList = true
                    }, label: {
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
                    shouldNavigateToSettings = true
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
    
    var drag: some Gesture {
        //https://stackoverflow.com/questions/60885532/how-to-detect-swiping-up-down-left-and-right-with-swiftui-on-a-view
        DragGesture(minimumDistance: 20, coordinateSpace: .global)
            .onEnded { value in
                let horizontalAmount = value.translation.width as CGFloat
                let verticalAmount = value.translation.height as CGFloat
                
                if abs(horizontalAmount) > abs(verticalAmount) {
                    horizontalAmount < 0 ? viewModel.changeTodoList() : print("no change")
                }
            }
    }
    
    
    
    // MARK: Initialization
    init(isPresented: Binding<Bool>, viewModel: TaskViewModel, viewFactory: ViewFactory) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        self.viewFactory = viewFactory
        
        //self.dateFormatter.locale = Locale(identifier: "en_US")
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .short
        
        self.noTasks = viewModel.noTasks
        self.noTodoLists = viewModel.noTodoLists
    }
    
    // MARK: Properties
    @State private var shouldNavigateToEditTask = false
    @State private var shouldNavigateToSettings = false
    @State private var shouldNavigateToTodoList = false
    //@State private var shouldNavigateToAddTodoList = false
    //@State private var shouldNavigateToAddTask = false
    
    @State private var noTasks: Bool
    @State private var noTodoLists: Bool
    
    //@State private var isDragging = false
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: TaskViewModel
    
    private let viewFactory: ViewFactory
    
    private var displayDateString: String {
        if let displayDate = viewModel.currentTask?.date {
            return self.dateFormatter.string(from: displayDate)
        } else {
            return ""
        }
    }
    
    private let dateFormatter: DateFormatter = DateFormatter()
    
    private var color: Color {
        return Color(.sRGB, red: Double(viewModel.currentTask?.todoList.redValue ?? 0), green: Double(viewModel.currentTask?.todoList.greenValue ?? 0), blue: Double(viewModel.currentTask?.todoList.blueValue ?? 0), opacity: 100)
    }
}

struct TaskView_Previews: PreviewProvider {
    @State static var isPresented = false

    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", orderIndex: 0, context: Injector.shared.persistentContainer.viewContext)
        
        _ = Task(date: Date(), name: "Preview Task", orderIndex: 0, weatherEnabled: false, todoList: todoList, dateEnabled: true, context: Injector.shared.persistentContainer.viewContext)
        return NavigationView {
            Injector.shared.viewFactory.taskView(isPresented: $isPresented)
        }
    }
}

