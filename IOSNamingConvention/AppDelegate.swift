//
//  AppDelegate.swift
//  IOSNamingConvention
//
//  Created by theonetech on 29/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppManager.shared.appStatus = .development
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        /// Added to have transparent navigationbar
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        self.isLoggedInUser()
        return true
    }
}

extension AppDelegate {
    /// redirect to home screen when user is already logged in.
    func isLoggedInUser() {
        let user = DefaultManager.getUserToken()
        if user?.access_token != nil {
            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let nav = UINavigationController(rootViewController: homeViewController)
            self.window!.rootViewController = nav
        } else {
            let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let nav = UINavigationController(rootViewController: loginViewController)
            self.window!.rootViewController = nav
        }
    }
}
