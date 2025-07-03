//
//  UserToken.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation

struct UserToken: Codable {
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var refresh_token: String?

    private enum CodingKeys: String, CodingKey {
        case access_token
        case token_type
        case expires_in
        case refresh_token
    }
}
