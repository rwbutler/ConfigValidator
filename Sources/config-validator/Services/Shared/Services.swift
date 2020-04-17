//
//  Services.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

struct Services {
    
    static var arguments: ArgumentsService {
        return CommandLineArgumentsService()
    }
    
    static var contentDeliveryNetwork: ContentDeliveryNetworkService {
        return AWSService(messagingService: messaging())
    }
    
    static func messaging(level: MessagingLevel = .default,
                          options: MessagingOptions = .console,
                          slackHookURL: URL? = nil) -> MessagingService {
        return DefaultMessagingService(level: level, options: options, slackHookURL: slackHookURL)
    }
    
    static var task: TaskService {
        return DefaultTaskService()
    }
    
    static var validator: ValidationService {
        return StrategicFileValidationService()
    }
    
    static var versionControl: VersionControlService {
        return GitVersionControlService()
    }

}
