//
//  TaskView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Task Name")
                .bold()
                .font(.system(size: 30))
                //.padding(.bottom, 75)
            Text("Date/Time")
                .padding(.top)
            HStack {
                Image(systemName: "cloud.sun.rain").padding(.vertical)
                Text("78*").padding(.vertical)
            }
            Button(action: {}, label: {
                Text("Complete").bold()
            })
            .padding(.bottom)
            .font(.system(size: 20))
            Button(action: {}, label: {
                Text("Skip")
            })
            
            Spacer()
        }.navigationTitle("Todo List Name")
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    Text("")
                        .frame(width: 0, height: 0)
                        .accessibilityHidden(true)
                    Button(action: {}, label: {
                        Image(systemName: "list.dash")
                            .font(Font.body)
                            .imageScale(.large)
                    }).accessibilityElement()
                    .accessibilityIdentifier("Show Todo Lists Button")
                    .accessibilityLabel("Show Todo Lists")
                    .accessibility(addTraits: .isButton)
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {}, label: {
                    Image(systemName: "gearshape")
                        .font(Font.body)
                        .imageScale(.large)
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Edit")
                })
            }
        })
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskView()
        }
    }
}
