//
//  HomeMenuItem.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation

class HomeMenuItems: Codable {
    let homeMenuItems: [HomeMenuItem]?
    
    private enum CodingKeys: String, CodingKey {
        case homeMenuItems = "home_menu"
        
    }
}
class HomeMenuItem: Codable {
 
    let title: String?
    let image: String?
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
    }
}
