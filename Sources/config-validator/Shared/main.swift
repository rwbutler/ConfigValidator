//
//  main.swift
//  Config Validator
//
//  Created by Ross Butler on 5/29/18.
//

import Foundation

var commandLineService = CommandLineProcessor()
let returnCode = commandLineService.main()
exit(returnCode.rawValue)
