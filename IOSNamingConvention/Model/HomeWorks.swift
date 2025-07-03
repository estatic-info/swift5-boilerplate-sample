//
//  HomeWorks.swift
//  IOSNamingConvention
//
//  Created by theonetech on 08/08/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation

class HomeWorks: Codable {
    
    var total: Int?
    var homeWorks: [HomeWork]?
    var currentPage: Int?
    var pageSize: Int?
    
    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case homeWorks = "items"
        case currentPage = "currentPage"
        case pageSize = "pageSize"
    }
}
class HomeWork: Codable {
 
    var id: Int?
    var userName: String?
    var subjectName: String?
    var date: String?
    var schoolId: Int?
    var standardId: Int?
    var subjectId: Int?
    var boardId: Int?
    var divisionId: Int?
    var dueDate: String?
    var description: String?
    var hasAttachment: Bool?
    
    private enum CodingKeys: String, CodingKey {
            case id = "total"
            case userName = "userName"
            case subjectName = "subjectName"
            case date = "date"
            case schoolId = "schoolId"
            case standardId = "standardId"
            case subjectId = "subjectId"
            case boardId = "boardId"
            case divisionId = "divisionId"
            case dueDate = "dueDate"
            case description = "description"
            case hasAttachment = "hasAttachment"
    }
}
