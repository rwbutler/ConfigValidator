//
//  ArgumentsService.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

protocol ArgumentsService {
    func processArguments(_ arguments: [String]) -> ConfigValidatorArguments?
}
