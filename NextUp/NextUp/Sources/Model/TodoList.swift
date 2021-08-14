//
//  TodoList+CoreDataClass.swift
//  NextUp
//
//  Created by Nate Koch on 8/5/21.
//
//

import Foundation
import CoreData
import SwiftUI

class TodoList: NSManagedObject {
    convenience init(redValue: Float, greenValue: Float, blueValue: Float, name: String, orderIndex: Int64, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.redValue = redValue
        self.greenValue = greenValue
        self.blueValue = blueValue
        self.orderIndex = orderIndex
        self.name = name
    }
}
