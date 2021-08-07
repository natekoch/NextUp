//
//  TaskEditView.swift
//  NextUp
//
//  Created by Nate Koch on 8/6/21.
//

import SwiftUI


struct TaskEditView: View {
    var body: some View {
        Form {
            Section(header: Text("Edit Task Name")) {
                TextField("Current Task Name", text: $newName)
                    .accessibility(label: Text("Change Task Name"))
            }
            Section(header: Text("Choose Due Date")) {
                Toggle("Enable Due Date", isOn: $isToggledDate)
                    .accessibility(label: Text("Toggle Due Date"))
                DatePicker("Due Date", selection: $newDate)
                    .accessibility(label: Text("Change Due Date"))
            }
            Section(header: Text("Display Weather?")) {
                Toggle("Display Weather", isOn: $isToggledWeather)
                    .accessibility(label: Text("Toggle Weather"))
            }
        }.accessibilityLabel("Edit Task Form")
        .navigationBarTitle("Edit New Task")
    }
    
    @State private var newName: String = ""
    @State private var isToggledDate: Bool = false
    @State private var newDate: Date = Date()
    @State private var isToggledWeather: Bool = false
    
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView()
    }
}
