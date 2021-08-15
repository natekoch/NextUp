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
                destination: viewFactory.taskEditView(isPresented: $shouldNavigateToEditTask, task: viewModel.currentTask!),
                isActive: $shouldNavigateToEditTask,
                label: {}).hidden()
            
            NavigationLink(destination: viewFactory.todoListView(todoList: viewModel.currentTodoList!), isActive: $shouldNavigateToTodoList, label: {}).hidden()
            
            NavigationLink(
                destination: viewFactory.settingsView(),
                isActive: $shouldNavigateToSettings,
                label: {}).hidden()
           
            
            
            VStack {
                Spacer()
                Text("Next Up:")
                    .bold()
                    .font(.system(size: 20))
                Text(self.viewModel.currentTask!.name)
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
                }, label: {
                    Image(systemName: "checkmark.circle.fill").resizable().frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.green)
                        
                })
                .padding(.bottom)
                .font(.system(size: 20))
                Button(action: {
                    viewModel.skipTask()
                }, label: {
                    Image(systemName: "arrow.right").resizable().frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                })
                Spacer()
            }.gesture(drag)
        }.navigationTitle(self.viewModel.currentTodoList!.name)
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
                    print(horizontalAmount < 0 ? viewModel.changeTodoList() : "right swipe")
                }
            }
    }
    
    
    // MARK: Initialization
    init(isPresented: Binding<Bool>, viewModel: TaskViewModel, viewFactory: ViewFactory) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        self.viewFactory = viewFactory
        
        self.dateFormatter.locale = Locale(identifier: "en_US")
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .short
        
        
    }
    
    // MARK: Properties
    @State private var shouldNavigateToEditTask = false
    @State private var shouldNavigateToSettings = false
    @State private var shouldNavigateToTodoList = false
    
    //@State private var isDragging = false
    
    @Binding private var isPresented: Bool
    @ObservedObject private var viewModel: TaskViewModel
    
    private let viewFactory: ViewFactory
    
    private var displayDateString: String {
        if let displayDate = viewModel.currentTask!.date {
            return self.dateFormatter.string(from: displayDate)
        } else {
            return ""
        }
    }
    
    private let dateFormatter: DateFormatter = DateFormatter()
    
    private var color: Color {
        return Color(.sRGB, red: Double(viewModel.currentTask!.todoList.redValue), green: Double(viewModel.currentTask!.todoList.greenValue), blue: Double(viewModel.currentTask!.todoList.blueValue), opacity: 100)
    }
}

struct TaskView_Previews: PreviewProvider {
    @State static var isPresented = false

    static var previews: some View {
        let todoList = TodoList(redValue: 1.0, greenValue: 0.0, blueValue: 1.0, name: "Test TodoList", orderIndex: 0, context: Injector.shared.persistentContainer.viewContext)
        
        _ = Task(date: Date(), name: "Preview Task", orderIndex: 0, weatherEnabled: false, todoList: todoList, context: Injector.shared.persistentContainer.viewContext)
        return NavigationView {
            Injector.shared.viewFactory.taskView(isPresented: $isPresented)
        }
    }
}

