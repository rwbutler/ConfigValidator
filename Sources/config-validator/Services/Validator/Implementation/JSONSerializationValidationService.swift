//
//  JSONFileValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

struct JSONSerializationValidationService: ValidationService {
    
    func isValid(fileURL: URL) -> Bool {
        guard let fileData = try? Data(contentsOf: fileURL) else {
            return false
        }
        let result = try? JSONSerialization.jsonObject(with: fileData, options: [.allowFragments])
        return result != nil
    }
    
}
