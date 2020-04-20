//
//  CommandLineProcessor.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

class CommandLineProcessor {
    
    // MARK: Dependencies
    private let argumentsService = Services.arguments
    private let cdnService = Services.contentDeliveryNetwork
    private var messagingService = Services.messaging()
    private let validator = Services.validator
    private let versionControlService = Services.versionControl
    
    func main() -> ReturnCode {
        guard let applicationArguments = argumentsService.processArguments(CommandLine.arguments) else {
            printUsage()
            return .invalidArguments
        }
        setMessagingLevel(using: applicationArguments)
        messagingService.message("\(applicationArguments.description)", level: .verbose)
        
        // Check whether all files pass validation
        let validationURLs: [URL] = applicationArguments.filePathArguments
        guard allFilesPassValidation(files: validationURLs) else {
            
            // Print files which have failed validation
            let failedValidation = validationURLs
                .filter({ !validator.isValid(fileURL: $0) })
                .map({ $0.description })
            let filesFailedValidation = failedValidation.joined(separator: ",")
            messagingService.message("The following files failed validation: \(filesFailedValidation)", level: .default)
            return .failedValidation
        }
        
        // Print files passing validation
        let filesValidatedSuccessfully = validationURLs
            .map({ "\($0) successfully validated." })
            .joined(separator: "\n")
        messagingService.message("\(filesValidatedSuccessfully)", level: .default)
        
        // Check whether upload enabled
        guard applicationArguments.uploadMethod == .awss3 else {
            guard validationURLs.count == applicationArguments.uploadURLs.count else {
                messagingService.message("Files argument count not equal to number of upload URLs count.", level: .warn)
                return .invalidArguments
            }
            return .invalidArguments
        }
        
        // Files to be uploaded
        let fileUploads: [(URL, URL)]
        
        // Determine files to upload (by checking whether version controlled repository)
        if let repositoryURL = validationURLs.first?.deletingLastPathComponent(),
            versionControlService.isToolchainInstalled(),
            versionControlService.isARepository(url: repositoryURL) {
            
            messagingService.message("Is a version controlled repository.", level: .verbose)
            printFilesModifiedInRepository(url: repositoryURL)
            fileUploads = filesToUpload(sourceURLs: validationURLs,
                                        destinationURLs: applicationArguments.uploadURLs,
                                        forceUpload: applicationArguments.forceUpload)
        } else {
            messagingService.message("Not a version controlled repository or toolchain not found.", level: .verbose)
            fileUploads = zip(validationURLs, applicationArguments.uploadURLs).map({ ($0, $1) })
        }
        
        // Upload files
        let uploadedFiles = uploadFiles(uploads: fileUploads)
        
        // Make uploaded files public
        let shouldMakeUploadedFilesPublic: Bool = applicationArguments.cloudFrontDistributionId != nil
        if shouldMakeUploadedFilesPublic {
            let madePublic = setPubliclyReadable(urls: uploadedFiles)
            
            // Invalidate cache
            guard let cloudFrontId = applicationArguments.cloudFrontDistributionId else {
                return .invalidArguments
            }
            invalidateURLs(madePublic, cloudFrontDistributionId: cloudFrontId)
        }
        return .success
    }
    
    /// Determines whether or not all of the files at the specified URLs passed validation successfully.
    func allFilesPassValidation(files: [URL]) -> Bool {
        return files.allSatisfy({ validator.isValid(fileURL: $0) })
    }
    
    // Determine which files should be uploaded.
    func filesToUpload(sourceURLs: [URL], destinationURLs: [URL], forceUpload: Bool = false) -> [(URL, URL)] {
        let uploads = zip(sourceURLs, destinationURLs).filter({ (sourceURL, _) in
            return forceUpload || isFileInLatestCommit(fileURL: sourceURL)
        })
        return uploads
    }
    
    /// Invalidates cache for files at the specified URLs.
    func invalidateURLs(_ urls: [URL], cloudFrontDistributionId: String) {
        guard !urls.isEmpty else { return }
        // Invalidate cache for uploaded filex
        let pathsToInvalidate = urls.map({ $0.path })
        messagingService.message("Invalidating files at: \(pathsToInvalidate.joined(separator: ",  "))",
            level: .default)
        cdnService.invalidateCache(distributionId: cloudFrontDistributionId, for: pathsToInvalidate)
    }
    
    /// Determines whether or not the specified file has been modified in the last Git commit.
    private func isFileInLatestCommit(fileURL: URL) -> Bool {
        guard let modifiedFiles = versionControlService.modifiedFilesInLatestCommit(workingDirectory: fileURL) else {
            return false
        }
        for modifiedFileName in modifiedFiles where fileURL.absoluteString.contains(modifiedFileName) {
            return true
        }
        return false
    }
    
    /// Sets files at specified URLs to public read.
    func setPubliclyReadable(urls: [URL]) -> [URL] {
        var madePublicSuccessfully: [URL] = []
        for uploadedFile in urls {
            let madePublic = cdnService.makePublic(url: uploadedFile)
            if madePublic {
                madePublicSuccessfully.append(uploadedFile)
                messagingService.message("Made \(uploadedFile.lastPathComponent) public.",
                    level: .default)
            } else {
                messagingService.message("Failed to make \(uploadedFile.lastPathComponent) public.",
                    level: .default)
            }
        }
        return madePublicSuccessfully
    }
    
    private func printFilesModifiedInRepository(url: URL) {
        guard let modifiedFiles = versionControlService.modifiedFilesInLatestCommit(workingDirectory: url) else {
            return
        }
        let modifiedFilesString = modifiedFiles.joined(separator: ", ")
        messagingService.message("Modified in latest commit: \(modifiedFilesString)",
            level: .verbose)
    }
    
    /// Provides guidance on how to use the application.
    private func printUsage() {
        let argumentUsage = CommandLineArgument.allCases
            .compactMap({ argument in
                if let extendedDescription = argument.extendedDescription() {
                    return "\(argument.rawValue): \(extendedDescription)"
                }
                return nil
            })
            .joined(separator: "\n")
        messagingService.message("\nUsage:\n\(argumentUsage)")
    }
    
    func uploadFiles(uploads: [(URL, URL)]) -> [URL] {
        var uploadedSuccessfully: [URL] = []
        
        for upload in uploads {
            let sourceURL = upload.0
            let destinationURL = upload.1
            
            let uploadSuccessful = cdnService.upload(fileURL: sourceURL, uploadURL: destinationURL)
            let sourceFileName = sourceURL.lastPathComponent
            let destinationFileName = destinationURL.lastPathComponent
            if uploadSuccessful {
                uploadedSuccessfully.append(destinationURL)
                let message = "Uploaded \(sourceFileName) to \(destinationFileName) successfully.\n"
                messagingService.message(message, level: .default)
            } else {
                let message = "Failed to upload \(sourceFileName) to \(destinationFileName).\n"
                messagingService.message(message, level: .default)
                break
            }
        }
        return uploadedSuccessfully
    }
    
}

private extension CommandLineProcessor {
    
    private func setMessagingLevel(using arguments: ConfigValidatorArguments) {
        messagingService = Services.messaging(
            level: arguments.messagingLevel,
            options: .all,
            slackHookURL: arguments.slackHookURL
        )
    }
    
    private func setPropertyListValidator(_ validator: PropertyListValidator) {
        propertyListValidator = validator
    }
    
}
