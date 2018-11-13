//
//  CommandLineArgument.swift
//  Config Validator
//
//  Created by Ross Butler on 6/1/18.
//

import Foundation

enum CommandLineArgument {
    
    case none
    case value(String)
    case cloudFrontDistributionId
    case forceUpload
    case files
    case silent
    case slackURL
    case uploadMethod
    case uploadURLs
    case verbose
    
    func extendedDescription() -> String? {
        switch self {
        case CommandLineArgument.cloudFrontDistributionId:
            return "Set to invalidate CloudFront distribution with the specified identifier."
        case CommandLineArgument.forceUpload:
            return "Uploads all validated files even where not modified in the latest commit."
        case CommandLineArgument.files:
            return "Specifies files to be validated."
        case CommandLineArgument.silent:
            return "(-s) Prevents output being emitted."
        case CommandLineArgument.slackURL:
            return "Set to output to a Slack hook URL."
        case CommandLineArgument.uploadMethod:
            return "Specifies the method of upload."
        case CommandLineArgument.uploadURLs:
            // swiftlint:disable:next line_length
            return "Specifies URLs to upload validated files to. Must contain same number of URLs as number of files to validate."
        case CommandLineArgument.verbose:
            return "(-v) Emits verbose output."
        case .none, .value:
            return nil
        }
    }
    
}

extension CommandLineArgument: CaseIterable {
    
    public static var allCases: [CommandLineArgument] {
        return [.cloudFrontDistributionId, .forceUpload, .files, .silent, .slackURL,
                .uploadMethod, .uploadURLs, .verbose]
    }
    
}

extension CommandLineArgument: RawRepresentable {

    public typealias RawValue = String
    
    init(rawValue: RawValue) {
        switch rawValue {
        case CommandLineArgument.cloudFrontDistributionId.description:
            self = .cloudFrontDistributionId
        case CommandLineArgument.forceUpload.description:
            self = .forceUpload
        case CommandLineArgument.files.description:
            self = .files
        case "-s", CommandLineArgument.silent.description:
            self = .silent
        case CommandLineArgument.slackURL.description:
            self = .slackURL
        case CommandLineArgument.uploadMethod.description:
            self = .uploadMethod
        case CommandLineArgument.uploadURLs.description:
            self = .uploadURLs
        case "-v", CommandLineArgument.verbose.description:
            self = .verbose
        default:
            self = .value(rawValue)
        }
    }
    
    public var rawValue: RawValue {
        return self.description
    }
    
}

extension CommandLineArgument: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .value(let string):
            return string
        case .cloudFrontDistributionId:
            return "--cloudfront-distribution-id"
        case .forceUpload:
            return "--force-upload"
        case .files:
            return "--files"
        case .silent:
            return "--silent"
        case .slackURL:
            return "--slack-url"
        case .uploadMethod:
            return "--upload-method"
        case .uploadURLs:
            return "--upload-urls"
        case .verbose:
            return "--verbose"
        }
    }
    
}
