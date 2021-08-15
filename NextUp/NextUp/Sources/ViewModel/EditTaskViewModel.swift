//
//  EditTaskViewModel.swift
//  NextUp
//
//  Created by Nate Koch on 8/13/21.
//

import Foundation
import SwiftUI

class EditTaskViewModel : ObservableObject {
    // MARK: Action
    func saveChanges() {
        guard canSave else {
            return
        }
        
        self.task.name = self.name
        self.task.date = self.date
        self.task.weatherEnabled = self.weatherEnabled
        self.task.dateEnabled = self.dateEnabled
        
        if dateEnabled {
            scheduleNotification()
        }
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = name
        content.subtitle = "Due Now"
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.hour,.minute,.day,.month,.year], from: self.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    
    // MARK: Initialization
    init(task: Task, taskRepository: TaskRepository) {
        self.task = task
        self.taskRepository = taskRepository
        self.name = task.name
        self.date = task.date ?? Date()
        self.weatherEnabled = task.weatherEnabled
        self.dateEnabled = task.dateEnabled
    }
    
    
    // MARK: Properties
    let task: Task
    
    @Published var name: String
    @Published var date: Date
    @Published var dateEnabled: Bool
    @Published var weatherEnabled: Bool
    private let taskRepository: TaskRepository
    
    var canSave: Bool {
        name != ""
    }
}
