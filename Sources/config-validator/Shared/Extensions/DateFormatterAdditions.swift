//
//  DateFormatterAdditions.swift
//  Config Validator
//
//  Created by Ross Butler on 7/17/18.
//

import Foundation

extension DateFormatter {
    
    /// Formats a Date to an ISO-8601 date and time representation including miliseconds.
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
