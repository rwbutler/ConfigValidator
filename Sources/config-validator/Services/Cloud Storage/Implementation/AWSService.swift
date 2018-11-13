//
//  AWSS3Service.swift
//  Config Validator
//
//  Created by Ross Butler on 5/31/18.
//

import Foundation

/// Wraps the Python AWS CLI providing methods to install where unavailable
struct AWSService: ContentDeliveryNetworkService {
    
    /// Delivers messages to the user
    let messagingService: MessagingService
    
    init(messagingService: MessagingService) {
        self.messagingService = messagingService
    }
    
    /// Invalidates CloudFront cache for paths and a given distribution identifier
    func invalidateCache(distributionId: String, for paths: [String]) {
        let pathsStr = paths.joined(separator: " ")
        let pipe = Pipe(),
        fileHandle = pipe.fileHandleForReading,
        awsCliS3Cp: Process = {
            let process = Process()
            process.launchPath = "/usr/bin/python"
            process.arguments = ["-m", "awscli", "cloudfront", "create-invalidation",
                                 "--distribution-id", distributionId, "--paths", pathsStr]
            process.standardOutput = pipe
            return process
        }()
        awsCliS3Cp.launch()
        let taskOutputData = fileHandle.readDataToEndOfFile()
        guard let taskOutput = String(data: taskOutputData, encoding: String.Encoding.utf8) else {
            fileHandle.closeFile()
            return
        }
        fileHandle.closeFile()
        if taskOutput.contains("command not found") {
            print("AWS CLI not found - would you like to install it? (y/n)")
            guard let response: String = readLine()?.lowercased() else {
                print("Aborting.")
                return
            }
            if response == "y" || response == "yes" {
                if installAWSCLI() { // retry if successful
                    invalidateCache(distributionId: distributionId, for: paths)
                }
            }
        }
    }
    
    /// Makes the file at the specified remote URL publicly readable
    func makePublic(url: URL) -> Bool {
        guard let bucketName = url.host else { return false }
        let key = String(url.path.dropFirst())
        return makePublic(bucketName: bucketName, key: key)
    }
    
    /// Uploads the file at the specified file URL to the specified remote URL
    func upload(fileURL: URL, uploadURL: URL) -> Bool {
        return performUpload(fileURL: fileURL, uploadURL: uploadURL)
    }
}

// Private
private extension AWSService {
    func installAWSCLI() -> Bool {
        messagingService.message("Installing AWS CLI...")
        let installPipe = Pipe(),
        installHandle = installPipe.fileHandleForReading,
        installProcess: Process = {
            let process = Process()
            process.launchPath = "brew"
            process.arguments = ["install", "awscli"]
            process.standardOutput = installPipe
            return process
        }()
        installProcess.launch()
        let installOutputData = installHandle.readDataToEndOfFile()
        guard let installOutput = String(data: installOutputData, encoding: String.Encoding.utf8) else {
            installHandle.closeFile()
            return false
        }
        messagingService.message(installOutput)
        if !installOutput.contains("Error") {
            messagingService.message("Installed. To uninstall run: `brew uninstall awscli`.")
            return true
        } else {
            messagingService.message("An error occurred whilst attepting to install the AWS CLI.")
            return false
        }
    }
    
    func makePublic(bucketName: String, key: String) -> Bool {
        let pipe = Pipe(),
        fileHandle = pipe.fileHandleForReading,
        awsS3PutObjectACL: Process = {
            let process = Process()
            process.launchPath = "/usr/bin/python"
            process.arguments = ["-m", "awscli", "s3api", "put-object-acl", "--bucket",
                                 bucketName, "--acl", "public-read", "--key", key]
            process.standardOutput = pipe
            return process
        }()
        awsS3PutObjectACL.launch()
        let taskOutputData = fileHandle.readDataToEndOfFile()
        guard let taskOutput = String(data: taskOutputData, encoding: String.Encoding.utf8) else {
            fileHandle.closeFile()
            return true // No output in the case of successful operation
        }
        fileHandle.closeFile()
        return !taskOutput.contains("error")
    }
    
    func performUpload(fileURL: URL, uploadURL: URL) -> Bool {
        let pipe = Pipe(),
        fileHandle = pipe.fileHandleForReading,
        awsCliS3Cp: Process = {
            let process = Process()
            process.launchPath = "/usr/bin/python"
            process.arguments = ["-m", "awscli", "s3", "cp", fileURL.path, uploadURL.absoluteString]
            process.standardOutput = pipe
            return process
        }()
        awsCliS3Cp.launch()
        let taskOutputData = fileHandle.readDataToEndOfFile()
        guard let taskOutput = String(data: taskOutputData, encoding: String.Encoding.utf8) else {
            fileHandle.closeFile()
            return false
        }
        if taskOutput.contains("command not found") {
            print("AWS CLI not found - would you like to install it? (y/n)")
            guard let response: String = readLine()?.lowercased() else {
                print("Aborting.")
                return false
            }
            if response == "y" || response == "yes" {
                if installAWSCLI() { // retry if successful
                    return performUpload(fileURL: fileURL, uploadURL: uploadURL)
                }
            }
        }
        fileHandle.closeFile()
        return taskOutput.contains("Completed")
    }
}
