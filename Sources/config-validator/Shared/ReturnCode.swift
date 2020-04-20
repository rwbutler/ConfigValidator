//
//  ReturnCode.swift
//  config-validator
//
//  Created by Ross Butler on 20/04/2020.
//

import Foundation

enum ReturnCode: Int32 {
    case success = 0
    case invalidArguments = 1
    case failedValidation
}
