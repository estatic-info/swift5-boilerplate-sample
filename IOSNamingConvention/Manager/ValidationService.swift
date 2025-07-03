//
//  ValidationService.swift
//  IOSNamingConvention
//
//  Created by Vivek Goswami on 8/18/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

struct ValidationService {
    func validateUserName(_ username : String?) -> Bool {
        if username?.validate(Type: .empty, Message: MessageText.Message.Validation.enter_username, showMessage : true) != true {
            return false
        }
//        else if username?.validate(Type: .email, Message: MessageText.message.validation.enter_valid_email, showMessage : true) != true {
//            return false
//        }
        return true
    }
    func validatePassword(_ password : String?) -> Bool {
        
        if password?.validate(Type: .empty, Message: MessageText.Message.Validation.enter_password, showMessage : true) != true {
            return false
        } else if password?.validate(Type: .lengthMax(digit: 6), Message: MessageText.Message.Validation.password_length, showMessage : true) != true {
            return false
        }
        return true
    }
}
enum ValidationError : LocalizedError {
    case emptyEmail
    case emptyPassword
    case validEmail
    case passwordLength
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return MessageText.Message.Validation.enter_email
        case .emptyPassword:
            return MessageText.Message.Validation.enter_username
        case .validEmail:
            return MessageText.Message.Validation.enter_valid_email
        case .passwordLength:
            return MessageText.Message.Validation.password_length
        }
    }
}
