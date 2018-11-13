//
//  Task.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

enum Task {
    case git(GitVersionControlAction, workingDirectory: URL?)
    
    var url: URL {
        switch self {
        case .git:
            return URL(fileURLWithPath: "/usr/bin/git")
        }
    }
}
