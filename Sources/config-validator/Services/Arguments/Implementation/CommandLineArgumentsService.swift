//
//  CommandLineArgumentsService.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

struct CommandLineArgumentsService: ArgumentsService {
    
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    func processArguments(_ arguments: [String]) -> ConfigValidatorArguments? {
        var cloudFrontDistributionId: String?
        var filePathArguments: [String] = []
        var forceUpload: Bool = false
        var messagingLevel: MessagingLevel = .default
        var slackHookURL: URL?
        var uploadURLs: [String] = []
        var parsingMode: CommandLineArgument = .none
        var propertyListValidator: PropertyListValidator = .propertyListSerialization
        
        for i in 1 ..< CommandLine.arguments.count {
            let argument = CommandLineArgument(rawValue: CommandLine.arguments[i])
            switch argument {
            case .cloudFrontDistributionId, .files, .propertyListValidator, .uploadURLs, .uploadMethod:
                parsingMode = argument
            case .forceUpload:
                parsingMode = .none
                forceUpload = true
            case .silent:
                parsingMode = .none
                messagingLevel = .none
            case .slackURL:
                parsingMode = .slackURL
            case .verbose:
                parsingMode = .none
                messagingLevel = .verbose
            case .value, .none:
                switch parsingMode {
                case .cloudFrontDistributionId:
                    cloudFrontDistributionId = argument.description
                case .files:
                    filePathArguments.append(argument.description)
                case .propertyListValidator:
                    propertyListValidator = self.propertyListValidator(from: argument.description)
                case .slackURL:
                    slackHookURL = URL(string: argument.description)
                case .uploadURLs:
                    uploadURLs.append(argument.description)
                default:
                    continue
                }
            }
        }
        return ConfigValidatorArguments(cloudFrontDistributionId: cloudFrontDistributionId,
                                        filePathArguments: filePathArguments,
                                        forceUpload: forceUpload,
                                        messagingLevel: messagingLevel,
                                        propertyListValidator: propertyListValidator,
                                        slackHookURL: slackHookURL,
                                        uploadURLs: uploadURLs)
    }
    
    /// Takes an argument and attempts to turn it into a Property List validator.
    private func propertyListValidator(from argument: String) -> PropertyListValidator {
        let result = PropertyListValidator.allCases.first { validator in
            return argument.lowercased() == validator.rawValue.lowercased()
        }
        return result ?? .propertyListSerialization
    }
    
}
