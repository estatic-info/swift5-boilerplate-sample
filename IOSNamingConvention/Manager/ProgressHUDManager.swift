//
//  ProgressHUDManager.swift
//  IOSNamingConvention
//
//  Created by Vivek Goswami on 8/12/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit
import KRProgressHUD

enum KRProgressHUDType {
    case `normal`
    case success
    case error
    case info
    case warning
}

class ProgressHUDManager: NSObject {
    // MARK: - Show KRProgressHUD
    static func showKRProgressHUD(_ isShow: Bool = true, Message message: String? = nil, type: KRProgressHUDType = .normal, deadline: Double = 2.0, withMessage : Bool = false) {
        DispatchQueue.main.async {
            if isShow {
                KRProgressHUD.set(deadline: deadline)
                if let message = message {
                    switch type {
                    case .success:
                        KRProgressHUD.showSuccess(withMessage: message)
                    case .error:
                        KRProgressHUD.showError(withMessage: message)
                    case .info:
                        KRProgressHUD.showInfo(withMessage: message)
                    case .warning:
                        KRProgressHUD.showWarning(withMessage: message)
                    default:
                        if withMessage {
                            KRProgressHUD.show(withMessage: message, completion: nil)
                        } else {
                            KRProgressHUD.showMessage(message)
                        }
                    }
                } else {
                    switch type {
                    case .success:
                        KRProgressHUD.showSuccess()
                    case .error:
                        KRProgressHUD.showError()
                    case .info:
                        KRProgressHUD.showInfo()
                    case .warning:
                        KRProgressHUD.showWarning()
                    default:
                        KRProgressHUD.show()
                    }
                }
            } else {
                KRProgressHUD.dismiss()
            }
        }
    }
}
