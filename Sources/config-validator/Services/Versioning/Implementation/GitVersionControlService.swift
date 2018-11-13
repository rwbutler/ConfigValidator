//
//  GitVersionControlService.swift
//  Config Validator
//
//  Created by Ross Butler on 5/30/18.
//

import Foundation

@objc class GitVersionControlService: NSObject, VersionControlService {
    private let taskService: TaskService = Services.task
    
    /// Determines whether or not the specified directory is a Git repository.
    func isARepository(url: URL) -> Bool {
        let expectedOutput = "not a git repository"
        guard let taskOutput = taskService.run(task: Task.git(.isInstalled, workingDirectory: url)) else {
            return false
        }
        return !taskOutput.lowercased().contains(expectedOutput)
    }
    
    /// Determines whether or not Git is installed.
    func isToolchainInstalled() -> Bool {
        let expectedOutput = "command not found"
        guard let taskOutput = taskService.run(task: Task.git(.isInstalled, workingDirectory: nil)) else {
            return false
        }
        return !taskOutput.lowercased().contains(expectedOutput)
    }

    /// Determines names of files modified in commit with the specified identifier.
    func modifiedFilesInCommit(commitIdentifier: String, workingDirectory: URL) -> [String]? {
        let expectedOutput = "not a git repository"
        guard let taskOutput = taskService.run(task:
            Task.git(.modifiedInCommit(identifier: commitIdentifier),
                     workingDirectory: workingDirectory)) else {
            return nil
        }
        guard !taskOutput.lowercased().contains(expectedOutput) else {
            return nil
        }
        return taskOutput.split(separator: "\n").map { String($0) }
    }
}
