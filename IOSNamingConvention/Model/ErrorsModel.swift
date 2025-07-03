//
//  ErrorModel.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation

class ErrorsModel: Codable {
    var errors: [ErrorModel]?
    
    private enum CodingKeys: String, CodingKey {
        case errors = "errors"
    }
}
class ErrorModel: Codable {
 
    var fieldName: String?
    var message: String?
    private enum CodingKeys: String, CodingKey {
        case fieldName = "fieldName"
        case message = "message"
    }
}
