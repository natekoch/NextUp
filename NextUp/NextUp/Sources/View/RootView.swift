//
//  RootView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct RootView: View {
    // MARK: View
    var body: some View {
        ZStack {
            // NextUp button Navigate
            NavigationLink(
                destination: viewFactory.taskView(isPresented: $shouldNavigateToTaskView),
                isActive: $shouldNavigateToTaskView,
                label: {}).hidden()
            
            // Settings Button Navigate
            NavigationLink(
                destination: viewFactory.settingsView(),
                isActive: $shouldNavigateToSettingsView,
                label: {}).hidden()
            
            VStack (alignment: .center, spacing: 30) {
                Button(action: {
                    shouldNavigateToTaskView = true
                }, label: {
                    Text("Next Up")
                        .bold()
                        .font(Font.system(size: 25))
                }).accessibilityElement()
                .accessibilityIdentifier("Next Up Button")
                .accessibilityLabel("Next Up")
                .accessibility(addTraits: .isButton)
                Button(action: {
                    shouldNavigateToSettingsView = true
                }, label: {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }).accessibilityElement()
                .accessibilityIdentifier("Settings Gear Button")
                .accessibilityLabel("Settings")
                .accessibility(addTraits: .isButton)
            }.padding(.bottom, 100)
        }
    }
    
    // MARK: Initialization
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    // MARK: Properties
    @State private var shouldNavigateToTaskView = false
    @State private var shouldNavigateToSettingsView = false
    
    private let viewFactory: ViewFactory
}

// MARK: Preview
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Injector.shared.viewFactory.rootView()
    }
}
