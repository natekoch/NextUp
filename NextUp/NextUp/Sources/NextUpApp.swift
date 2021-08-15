//
//  NextUpApp.swift
//  NextUp
//
//  Created by Nate Koch on 8/2/21.
//

import SwiftUI

@main
struct NextUpApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Injector.shared.viewFactory.rootView()
            }
        }
    }
}
