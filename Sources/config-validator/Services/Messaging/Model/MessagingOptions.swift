//
//  MessagingOptions.swift
//  Config Validator
//
//  Created by Ross Butler on 11/6/18.
//

import Foundation

struct MessagingOptions: OptionSet {
    let rawValue: Int
    
    static let console  = MessagingOptions(rawValue: 1 << 0)
    static let slack    = MessagingOptions(rawValue: 1 << 1)
    
    static let all: MessagingOptions = [.console, .slack]
}
