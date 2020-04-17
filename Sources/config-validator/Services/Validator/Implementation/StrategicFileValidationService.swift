//
//  StrategicFileValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 17/04/2020.
//

import Foundation

class StrategicFileValidationService: ValidationService {
    
    private typealias FileExtension = String
    private var validators: [FileExtension: ValidationService] = [:]
    
    init() {
        registerValidators()
    }
    
    func isValid(fileURL: URL) -> Bool {
        guard let fileValidator = validator(for: fileExtension(for: fileURL)) else {
            return false
        }
        return fileValidator.isValid(fileURL: fileURL)
    }
    
}

private extension StrategicFileValidationService {
    
    /// Returns the file extension for a given file URL.
    private func fileExtension(for fileURL: URL) -> String {
        return fileURL.pathExtension.lowercased()
    }
    
    /// Registers all validators for the relevant file extensions.
    private func registerValidators() {
        let allStrategies = FileValidationStrategy.allCases
        allStrategies.forEach { strategy in
            let validator = strategy.validator
            strategy.fileExtensions.forEach { fileExtension in
                registerValidator(validator, for: fileExtension)
            }
        }
    }
    
    /// Registers a validator to handle the specified file extension.
    private func registerValidator(_ validator: ValidationService, for fileExtension: FileExtension) {
        validators[fileExtension.lowercased()] = validator
    }
    
    /// Returns the validator registered to handle the given file extension, if one exists.
    private func validator(for fileExtension: FileExtension) -> ValidationService? {
        return validators[fileExtension.lowercased()]
    }
    
}
