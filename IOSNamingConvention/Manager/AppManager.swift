//
//  AppManager.swift
//  IOSNamingConvention
//
//  Created by theonetech on 29/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation
import UIKit

enum AppStatusType : Int {
    case production
    case staging
    case development
}
var window : UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController
}
class AppManager : NSObject {
    static let shared = AppManager()
    var appStatus : AppStatusType = .development
    var authToken : String?
    var uniqueID : String {
        return NSUUID().uuidString
    }
    
    // MARK: - Members
       override init() {
           super.init()
//           self.readToken()
       }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.kUserToken)
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            appdelegate.window?.rootViewController = UINavigationController(rootViewController: loginVC)
        }
    }
}

extension AppManager {
    // MARK: - App Info
    struct AppInfo {
        static let AppBundleID     : String = Bundle.main.bundleIdentifier ?? ""
    }
    
    struct DeviceInfo {
        static let DeviceUDID      = UIDevice.current.identifierForVendor?.uuidString ?? ""
        static let DeviceOSVersion = UIDevice.current.systemVersion
        static let DeviceType      = UIDevice.current.model
    }
}

struct VDDevice {
    
    // MARK: - Device Type
    struct Types {
        static let iPhone  = UI_USER_INTERFACE_IDIOM() == .phone
        static let iPad    = UI_USER_INTERFACE_IDIOM() == .pad
        static let CarPlay = UI_USER_INTERFACE_IDIOM() == .carPlay
        static let TV      = UI_USER_INTERFACE_IDIOM() == .tv
    }
    
    struct Model {
        static let iPhone4_5_W       = UIScreen.main.bounds.size.width == 320
        static let iPhone6_X_XS_W    = UIScreen.main.bounds.size.width == 375
        static let iPhone6P_XR_XSM_W = UIScreen.main.bounds.size.width == 414
        static let iPadMini_W        = UIScreen.main.bounds.size.width == 768
        static let iPadPro_10_5_W    = UIScreen.main.bounds.size.height == 834
        static let iPadPro_12_9_W    = UIScreen.main.bounds.size.width == 1024
        static let iPhone4_H         = UIScreen.main.bounds.size.height == 480
        static let iPhone5_H         = UIScreen.main.bounds.size.height == 568
        static let iPhone6_H         = UIScreen.main.bounds.size.height == 667
        static let iPhone6P_H        = UIScreen.main.bounds.size.height == 736
        static let iPhoneX_XS_H      = UIScreen.main.bounds.size.height == 812
        static let iPhoneXR_XSM_H    = UIScreen.main.bounds.size.height == 896
        static let iPadMini_H        = UIScreen.main.bounds.size.height == 1024
        static let iPadPro_10_5_H    = UIScreen.main.bounds.size.height == 1112
        static let iPadPro_12_9_H    = UIScreen.main.bounds.size.height == 1366
    }
    struct ScreenSize {
        static let devicewidth  = UIScreen.main.bounds.size.width
        static let deviceHeight = UIScreen.main.bounds.size.height
    }
    
}
extension AppManager {
    func showAlert(Title strTitle: String, Message strMsg: String, ButtonTitle strBtnTitle: String, ViewController VC: UIViewController,Back back:Bool? = false) {
        let alert = UIAlertController(title: strTitle, message: strMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: strBtnTitle, style: .default) { (_) in
            if back ?? false {
                VC.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {
            VC.present(alert, animated: true)
        }
    }
}
extension AppManager {
    static func readJSONFromFile(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                return data
                //json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return nil
    }
}
