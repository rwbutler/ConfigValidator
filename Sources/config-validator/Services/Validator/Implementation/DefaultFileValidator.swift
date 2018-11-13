//
//  DefaultFileValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

struct DefaultFileValidator: ValidationService {
    private let jsonValidator: ValidationService = JSONFileValidator()
    private let plistValidator: ValidationService = PLUtilPropertyListFileValidator()
    
    func isValid(fileURL: URL) -> Bool {
        switch fileURL.pathExtension.lowercased() {
        case "json":
            return jsonValidator.isValid(fileURL: fileURL)
        case "plist":
            return plistValidator.isValid(fileURL: fileURL)
        default:
            return false
        }
    }
}
