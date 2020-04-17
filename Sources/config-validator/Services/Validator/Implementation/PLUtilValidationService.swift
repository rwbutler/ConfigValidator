//
//  PropertyListValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

/// Uses PLUtil to check the syntax of a Property List file is valid.
struct PLUtilValidationService: ValidationService {
    
    func isValid(fileURL: URL) -> Bool {
        let pipe = Pipe(),
        fileHandle = pipe.fileHandleForReading
        plUtil(reading: fileURL.path, output: pipe).launch()
        let taskOutputData = fileHandle.readDataToEndOfFile()
        guard let taskOutput = String(data: taskOutputData, encoding: String.Encoding.utf8) else {
            fileHandle.closeFile()
            return false
        }
        fileHandle.closeFile()
        return taskOutput.contains("OK")
    }
    
}

private extension PLUtilValidationService {
    
    private func plUtil(reading filePath: String, output pipe: Pipe) -> Process {
        let process = Process()
        process.launchPath = "/usr/bin/plutil"
        process.arguments = [filePath]
        process.standardOutput = pipe
        return process
    }
    
}
