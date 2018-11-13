//
//  FileValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

protocol ValidationService {
    func isValid(fileURL: URL) -> Bool
}
