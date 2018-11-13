//
//  VersionControlService.swift
//  Config Validator
//
//  Created by Ross Butler on 5/30/18.
//

import Foundation

protocol VersionControlService {
    
    /// Determines whether or not the specified directory is a version controlled repository.
    func isARepository(url: URL) -> Bool
    
    /// Whether or not the version control toolchain is installed.
    func isToolchainInstalled() -> Bool
    
    /// Determines names of files modified in commit with the specified identifier
    func modifiedFilesInCommit(commitIdentifier: String, workingDirectory: URL) -> [String]?
    
    /// Determines names of files modified in the latest commit
    func modifiedFilesInLatestCommit(workingDirectory: URL) -> [String]?
    
}

extension VersionControlService {
    
    /// Determines names of files modified in the latest commit
    func modifiedFilesInLatestCommit(workingDirectory: URL) -> [String]? {
        return modifiedFilesInCommit(commitIdentifier: "HEAD", workingDirectory: workingDirectory)
    }
    
}
