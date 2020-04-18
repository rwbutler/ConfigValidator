//
//  JSONValidationTests.swift
//  Config Validator
//
//  Created by Ross Butler on 17/04/2020.
//

import Foundation
import XCTest

class JSONValidationTests: XCTestCase {
    
    func testValidJSONFilePassesValidation() {
        let currentBundle = Bundle(for: type(of: self))
        guard let validFile = currentBundle.url(forResource: "valid", withExtension: "json") else {
            XCTFail("Unable to load valid.json.")
            return
        }
        let jsonValidator = JSONSerializationValidationService()
        XCTAssertTrue(jsonValidator.isValid(fileURL: validFile))
        
        
        let strategicValidator = StrategicFileValidationService()
        XCTAssertTrue(strategicValidator.isValid(fileURL: validFile))
    }
    
    func testInvalidJSONFileFailsValidation() {
        let currentBundle = Bundle(for: type(of: self))
        guard let validFile = currentBundle.url(forResource: "invalid", withExtension: "json") else {
            XCTFail("Unable to load invalid.json.")
            return
        }
        let jsonValidator = JSONSerializationValidationService()
        XCTAssertFalse(jsonValidator.isValid(fileURL: validFile))
        
        let strategicValidator = StrategicFileValidationService()
        XCTAssertFalse(strategicValidator.isValid(fileURL: validFile))
    }
    
    func testEmptyJSONFileFailsValidation() {
        let currentBundle = Bundle(for: type(of: self))
        guard let validFile = currentBundle.url(forResource: "empty", withExtension: "json") else {
            XCTFail("Unable to load empty.json.")
            return
        }
        let jsonValidator = JSONSerializationValidationService()
        XCTAssertFalse(jsonValidator.isValid(fileURL: validFile))
        
        let strategicValidator = StrategicFileValidationService()
        XCTAssertFalse(strategicValidator.isValid(fileURL: validFile))
    }
    
}
