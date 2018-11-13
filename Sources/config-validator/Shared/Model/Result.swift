//
//  Result.swift
//  Config Validator
//
//  Created by Ross Butler on 7/23/18.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
