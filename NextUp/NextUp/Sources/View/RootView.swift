//
//  RootView.swift
//  NextUp
//
//  Created by Nate Koch on 8/3/21.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    private let viewFactory: ViewFactory
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Injector.shared.viewFactory.rootView()
    }
}
