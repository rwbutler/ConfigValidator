//
//  GitVersionControlAction.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

enum GitVersionControlAction {
    case isARepository
    case isInstalled
    case modifiedInCommit(identifier: String)
    
    var arguments: [String]? {
        switch self {
        case .isARepository:
            return ["status"]
        case .isInstalled:
            return ["status"]
        case .modifiedInCommit(let commitIdentifier):
            return ["diff-tree", "--no-commit-id", "--name-only", "-r", commitIdentifier]
        }
    }
    
}
