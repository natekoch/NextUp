//
//  NextUpApp.swift
//  NextUp
//
//  Created by Nate Koch on 8/2/21.
//

import SwiftUI

@main
struct NextUpApp: App {
    
    @State static var isPresented = true
    //var body: some Scene {
        //WindowGroup {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Injector.shared.viewFactory.taskView(isPresented: NextUpApp.$isPresented)
            }
        }
    }
}
