//
//  NextUpApp.swift
//  NextUp
//
//  Created by Nate Koch on 8/2/21.
//

import SwiftUI
import CoreData

@main
struct NextUpApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TaskEditView()
            }
        }
    }
}
