//
//  JSONFileValidator.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

struct JSONFileValidator: ValidationService {
    func isValid(fileURL: URL) -> Bool {
        guard let fileData = try? Data(contentsOf: fileURL),
            (try? JSONSerialization.jsonObject(with: fileData, options: [.allowFragments])) != nil
        else {
                return false
        }
        return true
    }
}
