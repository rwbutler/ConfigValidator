//
//  PropertyListValidationTests.swift
//  Config Validator Tests
//
//  Created by Ross Butler on 17/04/2020.
//

import Foundation
import XCTest

class PropertyListValidationTests: XCTestCase {
    
    func testValidPropertyListFilePassesValidation() {
        let currentBundle = Bundle(for: type(of: self))
        guard let validFile = currentBundle.url(forResource: "valid", withExtension: "plist") else {
            XCTFail("Unable to load valid.plist.")
            return
        }
        let plUtilValidator = PLUtilValidationService()
        XCTAssertTrue(plUtilValidator.isValid(fileURL: validFile))
        
        let propertyListSerializationValidator = PropertyListSerializationValidationService()
        XCTAssertTrue(propertyListSerializationValidator.isValid(fileURL: validFile))
        
        let strategicValidator = StrategicFileValidationService()
        XCTAssertTrue(strategicValidator.isValid(fileURL: validFile))
    }
    
    func testInvalidPropertyListFileFailsValidation() {
        let currentBundle = Bundle(for: type(of: self))
        guard let validFile = currentBundle.url(forResource: "invalid", withExtension: "plist") else {
            XCTFail("Unable to load invalid.plist.")
            return
        }
        let plUtilValidator = PLUtilValidationService()
        XCTAssertFalse(plUtilValidator.isValid(fileURL: validFile))
        
        let propertyListSerializationValidator = PropertyListSerializationValidationService()
        XCTAssertFalse(propertyListSerializationValidator.isValid(fileURL: validFile))
        
        let strategicValidator = StrategicFileValidationService()
        XCTAssertFalse(strategicValidator.isValid(fileURL: validFile))
    }
    
    func testEmptyPropertyListFileFailsValidation() {
        let currentBundle = Bundle(for: type(of: self))
        guard let validFile = currentBundle.url(forResource: "empty", withExtension: "plist") else {
            XCTFail("Unable to load empty.plist.")
            return
        }
        let plUtilValidator = PLUtilValidationService()
        XCTAssertFalse(plUtilValidator.isValid(fileURL: validFile))
        
        let propertyListSerializationValidator = PropertyListSerializationValidationService()
        XCTAssertFalse(propertyListSerializationValidator.isValid(fileURL: validFile))
        
        let strategicValidator = StrategicFileValidationService()
        XCTAssertFalse(strategicValidator.isValid(fileURL: validFile))
    }
    
}
