//
//  PropertyListSerializationValidationService.swift
//  config-validator
//
//  Created by Ross Butler on 18/04/2020.
//

import Foundation

// swiftlint:disable:next type_name
struct PropertyListSerializationValidationService: ValidationService {
    
    func isValid(fileURL: URL) -> Bool {
        guard let fileData = try? Data(contentsOf: fileURL) else {
            return false
        }
        let result = try? PropertyListSerialization.propertyList(from: fileData, options: [], format: nil)
        return result != nil
    }
    
}
