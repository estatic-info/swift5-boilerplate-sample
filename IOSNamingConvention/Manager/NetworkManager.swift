//
//  NetworkManager.swift
//  IOSNamingConvention
//
//  Created by Vivek Goswami on 8/12/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit
import Reachability

struct NetworkManager {
    
    static var isNetwork : Bool {
        if let connection = self.networkConnection {
            let isReach = connection != .none
            return isReach
        }
        return false
    }
    
    static var networkConnection : Reachability.Connection? {
        let connection = Reachability()?.connection
        return connection
    }
}
