//
//  FileValidationStrategy.swift
//  Config Validator
//
//  Created by Ross Butler on 17/04/2020.
//

import Foundation

enum FileValidationStrategy: CaseIterable {
    case json
    case propertyList
    
    var fileExtensions: [String] {
        switch self {
        case .json:
            return ["json"]
        case .propertyList:
            return ["plist"]
        }
    }
    
    var validator: ValidationService {
        switch self {
        case .json:
            return JSONSerializationValidationService()
        case .propertyList:
            return PLUtilValidationService()
        }
    }
}
