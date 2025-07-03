//
//  ReviewAPIClient.swift
//  IOSNamingConventionTests
//
//  Created by Vivek Goswami on 8/20/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import XCTest
@testable import IOSNamingConvention

class ReviewAPIClient : XCTestCase {
    
    // MARK: - API Calling Test Case
    func test_login_API_case() {
        let expectation = "Login response parse expectation"
        
        var loginParam = Login()
        loginParam.userName = ""
        loginParam.password = "test"
        loginParam.isStudent = true
        loginParam.schoolId = 1
        
        let request : APIManager = .login(login: loginParam)
        APIClient.requestObject(request, completion: { (userToken: UserToken) in
            print(expectation , userToken)
        }) { (errorMessage) in
            XCTFail(errorMessage ?? "")
        }
    }
    func test_home_work_list_case() {
        let expectation = "List of homeworks"
        let request : APIManager = .homeworks(pageNumber: -2, pageSize: 00)
        APIClient.requestObject(request, completion: { (response: HomeWorks) in
           print(expectation , response)
        }) { (error) in
            XCTFail(error ?? "")
        }
    }
    func test_album_list_case() {
        let expectation = "List of Album List"
        let request : APIManager = .albums(pageNumber: 1, pageSize: 10)
        APIClient.requestObject(request, completion: { (response: HomeWorks) in
            print(expectation , response)
        }) { (error) in
            XCTFail(error ?? "")
        }
    }
}
