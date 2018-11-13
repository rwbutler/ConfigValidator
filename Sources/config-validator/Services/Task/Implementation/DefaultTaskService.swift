//
//  DefaultTaskService.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

struct DefaultTaskService: TaskService {
    
    /// Executes the specified task and return the output, if any
    func run(task: Task) -> String? {
        let dispatchGroup = DispatchGroup()
        let pipe = Pipe()
        let pipeReader = pipe.fileHandleForReading
        let process = Process()
        switch task {
        case .git(let action, let workingDirectory):
            process.arguments = action.arguments
            if let currentDirectoryURL = workingDirectory {
                process.currentDirectoryURL = currentDirectoryURL
            }
        }
        process.executableURL = task.url
        process.standardOutput = pipe
        process.standardError = pipe
        process.terminationHandler = { (process) in
            dispatchGroup.leave()
        }
        do {
            dispatchGroup.enter()
            try process.run()
            dispatchGroup.wait()
            let processData = pipeReader.readDataToEndOfFile()
            guard let processOutput = String(data: processData, encoding: .utf8) else {
                pipeReader.closeFile()
                return nil
            }
            pipeReader.closeFile()
            return processOutput
        } catch _ {
            return nil
        }
    }
    
}
