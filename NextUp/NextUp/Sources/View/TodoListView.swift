//
//  TodoListView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct TodoListView: View {
    var body: some View {
        ZStack {
            List {
                Text("Clean Room")
                Text("Wash Car")
                Text("Organize Desk")
            }
        }.navigationTitle("Todo List Name")
        
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
