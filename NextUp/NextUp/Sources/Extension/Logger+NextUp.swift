//
//  Logger+NextUp.swift
//  NextUp
//
//  Created by Nate Koch on 8/6/21.
//

import Foundation
import OSLog


/**
    Creates a shared static on Logger that can be used for general logging purposes.
*/
extension Logger {
    static let shared = Logger(subsystem: subsystem, category: "shared")

    private static let subsystem = Bundle.main.bundleIdentifier!
}
