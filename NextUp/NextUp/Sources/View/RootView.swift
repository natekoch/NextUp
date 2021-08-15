//
//  RootView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            NavigationLink(
                destination: viewFactory.taskView(isPresented: $shouldNavigateToTaskView),
                isActive: $shouldNavigateToTaskView,
                label: {}).hidden()
            
            NavigationLink(
                destination: viewFactory.settingsView(),
                isActive: $shouldNavigateToSettingsView,
                label: {}).hidden()
            VStack {
                Button(action: {
                    shouldNavigateToTaskView = true
                }, label: {
                    Text("Next Up")
                        .bold()
                        .font(Font.system(size: 25))
                }).padding(.bottom)
                Button(action: {
                    shouldNavigateToSettingsView = true
                }, label: {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }).padding()
            }
        }
    }
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    @State private var shouldNavigateToTaskView = false
    @State private var shouldNavigateToSettingsView = false
    
    private let viewFactory: ViewFactory
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Injector.shared.viewFactory.rootView()
    }
}
