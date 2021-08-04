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
                .padding(.bottom, 75)
            Button(action: {}, label: {
                Text("Complete").bold()
            })
            .padding(.bottom)
            .font(.system(size: 20))
            Button(action: {}, label: {
                Text("Skip")
            })
            .font(.system(size: 18))
            Spacer()
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "gearshape")
                        .font(Font.body)
                        .imageScale(.large)
                })
                .padding(.leading, 18)
                Spacer()
            }
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
