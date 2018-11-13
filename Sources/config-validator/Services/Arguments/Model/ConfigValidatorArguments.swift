//
//  ConfigValidatorArguments.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

struct ConfigValidatorArguments {
    
    /// Required if cache invalidation is to be performed.
    let cloudFrontDistributionId: String?
    
    /// Files to be validated.
    var filePathArguments: [URL]
    
    /// Whether files should be uploaded even if validation fails.
    let forceUpload: Bool
    
    /// Determines the amount of output produced.
    let messagingLevel: MessagingLevel
    
    /// URL for posting Slack messages to.
    let slackHookURL: URL?
    
    /// Method to be used for uploading files.
    let uploadMethod: UploadMethod
    
    /// URLs to upload validated files to (must be same length as filePathArguments, otherwise will be ignored).
    let uploadURLs: [URL]
    
    init?(cloudFrontDistributionId: String?,
          filePathArguments: [String],
          forceUpload: Bool,
          messagingLevel: MessagingLevel,
          slackHookURL: URL?,
          uploadURLs: [String]) {
        self.cloudFrontDistributionId = cloudFrontDistributionId
        self.filePathArguments = filePathArguments.compactMap({ URL(fileURLWithPath: $0) })
        if self.filePathArguments.isEmpty { return nil }
        self.forceUpload = forceUpload
        self.messagingLevel = messagingLevel
        self.slackHookURL = slackHookURL
        self.uploadMethod = uploadURLs.allSatisfy({ $0.starts(with: "s3://") })
            ? .awss3
            : .none
        self.uploadURLs = uploadURLs.compactMap({ URL(string: $0) })
    }
    
}

extension ConfigValidatorArguments: CustomStringConvertible {
    
    var description: String {
        let unsetParameterStr = "<not set>"
        let uploadFiles = zip(filePathArguments, uploadURLs)
        let uploadFilesStr = uploadURLs.isEmpty
            ? unsetParameterStr
            : uploadFiles.map({ "\($0) -> \($1)" }).joined(separator: ",")
        let validationFilesStr = filePathArguments.isEmpty
            ? unsetParameterStr
            : filePathArguments.map({ $0.description }).joined(separator: ",")
        return """
        AWS CloudFront distribution identifier: \(cloudFrontDistributionId ?? unsetParameterStr)
        Files to validate: \(validationFilesStr)
        Force upload: \(forceUpload)
        Messaging level: \(messagingLevel)
        Slack hook URL: \(slackHookURL?.description ?? unsetParameterStr)
        Upload method: \(uploadMethod)
        Upload URLs: \(uploadFilesStr)
        """
    }
    
}
