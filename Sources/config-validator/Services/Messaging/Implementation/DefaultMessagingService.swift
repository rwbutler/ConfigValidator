//
//  DefaultMessagingService.swift
//  Config Validator
//
//  Created by Ross Butler on 11/6/18.
//

import Foundation

class DefaultMessagingService: MessagingService {
    
    var messagingLevel: MessagingLevel {
        didSet {
            messagingServices.forEach({ $0.messagingLevel = messagingLevel })
        }
    }
    let messagingServices: [MessagingService]
    
    init(level: MessagingLevel = .default, options: MessagingOptions = .all, slackHookURL: URL? = nil) {
        self.messagingLevel = level
        var services: [MessagingService] = []
        if options.contains(.console) {
            services.append(ConsoleMessagingService(level: level))
        }
        if options.contains(.slack), let hookURL = slackHookURL {
            services.append(SlackMessagingService(hookURL: hookURL, level: level))
        }
        self.messagingServices = services
    }
    
    func message(_ message: String, level: MessagingLevel) {
        messagingServices.forEach({ messagingService in
            messagingService.message(message, level: level)
        })
    }
}
