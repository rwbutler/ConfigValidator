//
//  TaskService.swift
//  Config Validator
//
//  Created by Ross Butler on 11/8/18.
//

import Foundation

protocol TaskService {
    func run(task: Task) -> String?
}
