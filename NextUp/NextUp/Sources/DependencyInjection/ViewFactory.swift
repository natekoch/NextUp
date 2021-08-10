//
//  ViewFactory.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//

import Foundation
import SwiftUI

class ViewFactory {
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    private let taskRepository: TaskRepository
}
