//
//  PropertyListValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

/// Uses PLUtil to check the syntax of a Property List file is valid.
struct PLUtilPropertyListFileValidator: ValidationService {
    func isValid(fileURL: URL) -> Bool {
        let pipe = Pipe(),
        fileHandle = pipe.fileHandleForReading,
        plUtil: Process = {
            let process = Process()
            process.launchPath = "/usr/bin/plutil"
            process.arguments = [fileURL.path]
            process.standardOutput = pipe
            return process
        }()
        plUtil.launch()
        let taskOutputData = fileHandle.readDataToEndOfFile()
        guard let taskOutput = String(data: taskOutputData, encoding: String.Encoding.utf8) else {
            fileHandle.closeFile()
            return false
        }
        fileHandle.closeFile()
        return taskOutput.contains("OK")
    }
}
