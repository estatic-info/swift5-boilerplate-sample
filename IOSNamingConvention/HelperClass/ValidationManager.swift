//
//  ValidationManager.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

struct VDRegex {
    static let email = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
}

class ValidationManager: NSObject {
    static let shared = ValidationManager()
    
    struct Validation {
        struct Password {
            static let minimum = 8
            static let maximum = 15
        }
        struct Mobile {
            static let maximum = 10
        }
    }
}

extension ValidationManager {
    // MARK: - ValidationType
    enum ValidationType {
        case empty
        case email
        case lengthMax(digit: Int)
        case lengthMin(digit: Int)
        case equal
    }
}

extension String {
    func validate(Type type:ValidationManager.ValidationType, withString str2nd:String? = nil, Message message:String? = nil, showMessage : Bool = false) -> Bool {
        switch type {
        case .empty:
            if self.trim.isEmpty {
                if showMessage {
                   ProgressHUDManager.showKRProgressHUD(Message: message, type: .error, withMessage: true)
                }
                return false
            }
        case .email:
            if !self.isValidEmail {
               ProgressHUDManager.showKRProgressHUD(Message: message, type: .error, withMessage: true)
                return false
            }
        case .lengthMin(let digit):
            if !self.trim.lengthMin(Length: digit) {
               ProgressHUDManager.showKRProgressHUD(Message: message, type: .error, withMessage: true)
                return false
            }
        case .lengthMax(let digit):
            if !self.trim.lengthMax(Length: digit) {
               ProgressHUDManager.showKRProgressHUD(Message: message, type: .error, withMessage: true)
                return false
            }
        case .equal:
            if self != str2nd {
               ProgressHUDManager.showKRProgressHUD(Message: message, type: .error, withMessage: true)
                return false
            }
        }
        return true
    }
}
