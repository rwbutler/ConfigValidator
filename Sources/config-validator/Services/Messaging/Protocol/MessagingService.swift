//
//  MessagingService.swift
//  Config Validator
//
//  Created by Ross Butler on 5/30/18.
//

import Foundation

protocol MessagingService: class {
    
    /// Sets the log level at which output will be emitted.
    var messagingLevel: MessagingLevel { get set }
    
    /// Sends message at the default log level.
    func message(_ message: String, level: MessagingLevel)
    
}

extension MessagingService {
    
    /// Retrieves the name of the application.
    func applicationName() -> String {
        return "Config Validator"
    }
    
    /// Convenience method for sending messages at the default log level.
    func message(_ message: String) {
        self.message(message, level: .default)
    }
    
}
