//
//  APIWebService.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/26/22.
//

import RxSwift
import Alamofire
import RxAlamofire
 
struct APIWebService {
    static func createRequest(
        method: Alamofire.HTTPMethod,
        path: String,
        parameters: [String: Any]?,
        jsonObject: Any? = nil,
        timeout: TimeInterval? = nil
        ) throws -> URLRequest
    {
        var mutableURLRequest: NSMutableURLRequest!
        
        let url = try APIEndpoint.BASE_URL.asURL()
        mutableURLRequest = NSMutableURLRequest(url: url.appendingPathComponent(path))
           
        mutableURLRequest.httpMethod = method.rawValue
        mutableURLRequest.setValue(RapidAPI.KEY, forHTTPHeaderField: "X-RapidAPI-Key")
        mutableURLRequest.setValue(RapidAPI.HOST, forHTTPHeaderField: "X-RapidAPI-Host")
        mutableURLRequest.cachePolicy = .useProtocolCachePolicy
        
        if let timeout = timeout {
            mutableURLRequest.timeoutInterval = timeout
        }
         
        if method == .get {
            return try URLEncoding.default.encode(mutableURLRequest as URLRequest, with: parameters)
        } else {
            if let jsonObj = jsonObject {
                return try JSONEncoding.default.encode(mutableURLRequest as URLRequest, withJSONObject: jsonObj)
            } else {
                return try JSONEncoding.default.encode(mutableURLRequest as URLRequest, with: parameters)
            }
        }
    }
}
