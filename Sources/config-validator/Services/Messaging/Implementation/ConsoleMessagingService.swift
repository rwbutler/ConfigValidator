//
//  DefaultMessagingService.swift
//  Config Validator
//
//  Created by Ross Butler on 5/30/18.
//

import Foundation

class ConsoleMessagingService: MessagingService {
    var messagingLevel: MessagingLevel
    
    init(level: MessagingLevel = .default) {
        self.messagingLevel = level
    }
    
    func message(_ message: String, level: MessagingLevel = .default) {
        if UInt8(level.rawValue) <= UInt8(messagingLevel.rawValue) {
            print("\(applicationName()): \(message)\n")
        }
    }
}
