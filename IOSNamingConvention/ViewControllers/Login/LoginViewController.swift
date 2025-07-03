//
//  LoginViewController.swift
//  IOSNamingConvention
//
//  Created by theonetech on 29/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    private let validation = ValidationService()
    
//    init(validation : ValidationService) {
//        self.validation = validation
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        self.validation = ValidationService()
//        super.init(coder:coder)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    func initialize() {
        self.title = Navigation.login
        textFieldUserName.addBottomBorder()
        textFieldPassword.addBottomBorder()
    }
    /// Action button for login
    @IBAction func actionLogin(_ sender: UIButton) {
        if performLoginValidation() {
            var loginParam = Login()
            loginParam.userName = self.textFieldUserName.text
            loginParam.password = self.textFieldPassword.text
            loginParam.isStudent = true
            loginParam.schoolId = 1
            onLogin(login: loginParam)
        }
    }
}
// MARK: FieldValidation
extension LoginViewController {
    // MARK: - Validation
    func performLoginValidation() -> Bool {
        if !validation.validateUserName(self.textFieldUserName.text) {
            return false
        }
        if !validation.validatePassword(self.textFieldPassword.text) {
            return false
        }
        return true
    }
}
// MARK: ApiCall
extension LoginViewController {
    func onLogin(login : Login) {
        
        let request : APIManager = .login(login: login)
        APIClient.requestObject(request, completion: { (userToken: UserToken) in
            DispatchQueue.main.async {
                ProgressHUDManager.showKRProgressHUD(false)
                DefaultManager.setUserToken(UserToken: userToken)
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.isLoggedInUser()
                }
            }
        }) { (errorMessage) in
            AppManager.shared.showAlert(Title: MessageText.Text.error, Message: errorMessage ?? MessageText.Message.something_went_wrong, ButtonTitle: "Ok", ViewController: self)
        }
    }
}
