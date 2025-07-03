//
//  Albums.swift
//  IOSNamingConvention
//
//  Created by theonetech on 08/08/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation

class Albums: Codable {
    var total: Int?
    var albums: [Album]?
    var currentPage: Int?
    var pageSize: Int?
    
    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case albums = "items"
        case currentPage = "currentPage"
        case pageSize = "pageSize"
    }
}
class Album: Codable {
 
    var id: Int?
    var name: String?
    var photoUrl: String?
    var count: Int?
    var date: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photoUrl = "photoUrl"
        case count = "count"
        case date = "date"
    }
}
