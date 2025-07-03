//
//  Login.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation

struct Login: Codable {
    var userName: String?
    var password: String?
    var schoolId: Int?
    var isStudent: Bool? 

    private enum CodingKeys: String, CodingKey {
        case userName
        case password
        case schoolId
        case isStudent
    }
}
