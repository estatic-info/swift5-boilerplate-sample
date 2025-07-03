//
//  APIManager.swift
//  IOSNamingConvention
//
//  Created by theonetech on 29/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import Foundation
import Reachability
import Alamofire

/// Set base url
var baseURL : String {
    
    switch AppManager.shared.appStatus {
    case .production:
        return "http://127.0.0.1/"
    case .development:
        return "http://127.0.0.1/"
    case .staging:
        return "http://127.0.0.1/"
    }
}
enum APIManager {
    /// UserLogin
    case login(login: Login)
    case homeworks(pageNumber: Int, pageSize: Int)
    case albums(pageNumber: Int, pageSize: Int)
}

extension APIManager {
    
    fileprivate var urlAndMethod: (String, Alamofire.HTTPMethod) {
        
        switch self {
        case .login:
            return (baseURL, .post)
        default:
            return (baseURL, .get)
        }
    }

    var endPoint: (path: String, params: [String: Any]?) {
        switch self {
        /// UserLogin
        case .login(let login):
            return ("Auth/Login", login.dictionary)
        case .homeworks(let pageNumber, let pageSize):
            return ("HomeWorks", ["pageNumber": pageNumber,"pageSize": pageSize])
        case .albums(let pageNumber, let pageSize):
            return ("Albums", ["pageNumber": pageNumber,"pageSize": pageSize ])
        }
    }
    
    /**
     Main key value of response
     */
    var keyPath: String? {
        switch self {
        default:
            return nil
        }
    }
}

extension APIManager: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        
        let (baseURL, httpMethod) = urlAndMethod
        let strURL : String = baseURL + endPoint.path
        var urlMain : URL? = URL(string: strURL)
        if urlMain == nil {
            urlMain = URL(string: strURL.encode)
        }
        guard let url = urlMain else {
            fatalError( "Request URL invalid for \(self)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        let userToken =  DefaultManager.getUserToken()
        
        if let tokenValue = userToken?.access_token {
            switch self {
            case .login:
                break
            default:
                request.addValue("Bearer \(tokenValue)", forHTTPHeaderField: "Authorization")
            }
        }
        
        var encodedURLRequest: URLRequest
        let params: [String: Any]? = endPoint.params
        switch self {
        case .homeworks, .albums:
            encodedURLRequest = try URLEncoding.queryString.encode(request as URLRequestConvertible, with: params)
        default:
            encodedURLRequest = try JSONEncoding.default.encode(request as URLRequestConvertible, with: params)
        }
        
        if encodedURLRequest.url != nil {
            print("Request \(endPoint.path)")
        }
        
        print("Requested URL : \n\(httpMethod) : \(url.absoluteString)\nParameter : \(params ?? ["":""])\nToken : \(encodedURLRequest.allHTTPHeaderFields ?? ["":""])")
        
        return encodedURLRequest
    }
}
