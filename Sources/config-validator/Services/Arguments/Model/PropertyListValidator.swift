//
//  PropertyListValidator.swift
//  config-validator
//
//  Created by Ross Butler on 18/04/2020.
//

import Foundation

var propertyListValidator: PropertyListValidator = .propertyListSerialization

enum PropertyListValidator: String, CaseIterable {
    case plUtil
    case propertyListSerialization
}
