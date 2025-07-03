//
//  ValidationTestCase.swift
//  IOSNamingConventionTests
//
//  Created by Vivek Goswami on 8/20/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import XCTest
@testable import IOSNamingConvention

class ValidationTestCase: XCTestCase {

    var validation : ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    // MARK: - Login Input Test Cases
    func test_empty_username() {
        XCTAssert(validation.validateUserName("abc@gmail.com"), ValidationError.emptyEmail.localizedDescription)
    }
    func test_valid_username() {
        XCTAssert(validation.validateUserName("abc@gmail.com"), ValidationError.validEmail.localizedDescription)
    }
    func test_empty_password() {
        XCTAssert(validation.validatePassword("23456789"), ValidationError.emptyPassword.localizedDescription)
    }
    func test_password_length() {
        XCTAssert(validation.validatePassword("23456789"), ValidationError.passwordLength.localizedDescription)
    }
    func test_username_is_nil() {
        XCTAssert(validation.validateUserName("abc@gmail.com"), ValidationError.emptyEmail.localizedDescription)
    }

}
