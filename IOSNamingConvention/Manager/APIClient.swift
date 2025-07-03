//
//  ApiCallManager.swift
//  IOSNamingConvention
//
//  Created by theonetech on 30/07/20.
//  Copyright © 2020 theonetech. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireCodable
import KRProgressHUD

public class APIClient: NSObject {
    public static let shared : APIClient = APIClient()
    public typealias SuccessHandler<T: Codable> = ((T) -> Void)
    public typealias FailureHandler = ((String?) -> Void)
}

extension APIClient {
    
    static func requestObject<T: Codable>(_ request: APIManager, completion: SuccessHandler<T>? = nil, ErrorBlock errorBlock : FailureHandler? = nil) {
        ProgressHUDManager.showKRProgressHUD()
        
        print("request URL : \(request.urlRequest?.url?.absoluteString ?? "")")
        print("request Parameter : \(request.endPoint.params ?? [:])")
        
        Alamofire.request(request).responseObject(queue: .global(), keyPath: request.keyPath) { (response : DataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion?(value)
            case .failure(_):
                ProgressHUDManager.showKRProgressHUD(false)
                self.handleError(request: request, responseObject: response, responseList: nil, failure: errorBlock, statusCode: response.response?.statusCode ?? 0)
            }
        }
    }
    static func requestList<T: Codable>(_ request: APIManager, completion: SuccessHandler<[T]>? = nil, ErrorBlock errorBlock : FailureHandler? = nil) {
        
       ProgressHUDManager.showKRProgressHUD(true)
        
        print("request URL : \(request.urlRequest?.url?.absoluteString ?? "")")
        print("request Parameter : \(request.endPoint.params ?? [:])")
        
        Alamofire.request(request).responseArray(queue: .global(), keyPath: request.keyPath) { (response : DataResponse<[T]>) in
            switch response.result {
            case .success(let value):
                completion?(value)
            case .failure(_):
               ProgressHUDManager.showKRProgressHUD(false)
                self.handleError(request: request, responseObject: response, responseList: nil, failure: errorBlock, statusCode: response.response?.statusCode ?? 0)
            }
        }
    }
    static func handleError<T: Any>(request: APIManager, responseObject: DataResponse<T>? = nil, responseList: DataResponse<[T]>? = nil, failure: FailureHandler? = nil, statusCode: Int) {
        
        debugPrint("\(Date().description): \(#function) statusCode:\(statusCode)")
        
        var strMessage : String?
        var error : Error?
        
        if let response = responseObject {
            debugPrint("\(#function) result:\(response.result.value.debugDescription ), error:\(response.error?.localizedDescription ?? "n/a")")
            error = response.result.error
        } else if let response = responseList {
            debugPrint("\(#function) result:\(response.result.value.debugDescription ), error:\(response.error?.localizedDescription ?? "n/a")")
            error = response.result.error
        }
        
        if strMessage == nil {
            strMessage = error?.localizedDescription
        }
        
        let message = strMessage ?? MessageText.Message.something_went_wrong
        failure?(message)
    }
}
