//
//  ServiceRouter.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/26/22.
//

import Foundation
import RxAlamofire
import Alamofire

enum ServiceRouter: URLRequestConvertible {
    case getMarketSummary
    case getStocksDetails(String)
    case autoComplete(String)
    
    func asURLRequest() throws -> URLRequest {
        let req: (method: Alamofire.HTTPMethod, path: String, parameters: Parameters?, jsonSerializableObj: Any?) = {
            switch self {
            case .getMarketSummary:
                return (.get, "market/v2/get-summary", nil, nil)
            case .getStocksDetails(let stockSymbol):
                return (.get, "stock/v2/get-summary", ["symbol": stockSymbol], nil)
            case .autoComplete(let searchString):
                return (.get, "auto-complete", ["q": searchString], nil)
            }
        }()
        
        if let jsonObject = req.jsonSerializableObj {
            return try APIWebService.createRequest(method: req.method, path: req.path, parameters: nil, jsonObject: jsonObject)
        } else {
            return try APIWebService.createRequest(method: req.method, path: req.path, parameters: req.parameters)
        }
    }
}

