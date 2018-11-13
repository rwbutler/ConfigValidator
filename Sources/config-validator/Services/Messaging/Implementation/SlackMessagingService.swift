//
//  SlackMessagingService.swift
//  Config Validator
//
//  Created by Ross Butler on 7/17/18.
//

import Foundation

class SlackMessagingService: MessagingService {
    let hookURL: URL
    var messagingLevel: MessagingLevel
    
    init(hookURL: URL, level: MessagingLevel = .default) {
        self.hookURL = hookURL
        self.messagingLevel = level
    }
    
    func message(_ message: String, level: MessagingLevel = .default) {
        if UInt8(level.rawValue) <= UInt8(messagingLevel.rawValue) {
            let formattedMessage = "\(applicationName()): \(message)\n"
            var request = URLRequest(url: hookURL)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
          
            request.httpBody = "payload={\"text\": \"\(formattedMessage)\"}".data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(String(describing: error))
                    return
                }
                if let httpStatus = response as? HTTPURLResponse,
                    httpStatus.statusCode != 200 {
                    let statusCode = httpStatus.statusCode
                    let fullResponse = String(describing: response)
                    print("Returned non-200 status code: \(statusCode)\n with response: \(fullResponse)")
                    if let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                }
            }
            task.resume()
        }
    }
}
