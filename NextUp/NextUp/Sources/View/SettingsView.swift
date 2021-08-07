//
//  SettingsView.swift
//  NextUp
//
//  Created by Nate Koch on 8/4/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Text("Todo List Cell")
            Text("Another Todo List Cell.")
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
