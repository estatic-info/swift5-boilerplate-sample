//
//  Constant.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

struct Storyboard {
    static let main = "Main"

}
struct Controller {
    static let login = "LoginViewController"
    static let home = "HomeViewController"
}

struct Navigation {
    static let home = "Home"
    static let login = "Login"
}
struct Cell {
    static let HomeViewCell = "HomeViewCell"

}

struct UserDefaultsKeys {
    static let kUserToken    = "UserToken"
    static let kAuthorization    = "Authorization"
    static let kTokenExpiration    = "TokenExpiration"
}

// MARK: Numerical Constants
struct ErrorCode {
    static let StatusSuccess = 1
    static let ResponseStatusSuccess = 200
    static let ResponseStatusCreated = 201
    static let ResponseStatusAccepted = 202
    static let ResponseStatusNoResponse = 204
    static let ResponseStatusForbidden = 401
    static let ResponseStatusAleradyExist = 409
    static let ResponseStatusEmailNotFound = 422
    static let ResponseStatusServerError = 500
    static let ResponseInvalidCredential = 401
    static let ResponseStatusUserNotExist = 404
}

struct JSONFile {
    static let homeMenuItems = "HomeMenuItems"
}

struct MessageText {
    // MARK: - Messages Text Declaration
    struct Text {
        static let cancel        = "Cancel"
        static let dismiss       = "Dismiss"
        static let ok            = "OK"
        static let done          = "Done"
        static let alert         = "Alert !!"
        static let success       = "Success !!"
        static let error         = "Error !!"
        static let try_again     = "Try Again"
        static let yes           = "YES"
        static let no            = "NO"
        static let loading       = "Loading..."
        static let in_progress   = "In Progress..."
        static let logout        = "Logout"
    }
    struct Message {
        static let network_error                    = "Network not available !!"
        static let something_went_wrong             = "Something went wrong !!"
        static let something_went_wrong_detail      = "Something went wrong with availble detail. Please try again."
        static let data_cannot_parse                = "Sorry, data cannot be parsed."
        struct Validation {
            static let enter_username         = "Enter username"
            static let enter_email            = "Enter email"
            static let enter_valid_email      = "Enter valid email"
            static let enter_password         = "Enter password"
            static let password_length        = "Password must be 6 character long"
        }
    }
}
