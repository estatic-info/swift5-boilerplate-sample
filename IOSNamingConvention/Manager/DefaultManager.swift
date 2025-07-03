//
//  DefaultManager.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit

class DefaultManager: NSObject {

    static func setUserToken(UserToken userToken : UserToken) {
        UserDefaults.standard.set(userToken.dictionary, forKey: UserDefaultsKeys.kUserToken)
        UserDefaults.standard.synchronize()
    }
    static func getUserToken() -> UserToken? {
        let userTokenJSON = UserDefaults.standard.value(forKey: UserDefaultsKeys.kUserToken) as? [String:Any] ?? [:]
        guard let data = try? JSONSerialization.data(withJSONObject: userTokenJSON, options: .prettyPrinted) else { return nil }

        let decoder = JSONDecoder()
        do {
            let userToken = try decoder.decode(UserToken.self, from: data)
            print(userToken)
            return userToken
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
