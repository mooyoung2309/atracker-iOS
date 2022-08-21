//
//  CompanyRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Foundation
import Alamofire

enum CompanyAPI{
    case companies(CompanyCreateRequests)
    case search(CompanySearchQuery, CompanySearchCondition)
}

extension CompanyAPI: BaseURLRequestConvertible {
    var baseURL: String {
        return Key.baseURL + "/company"
    }
    
    var method: HTTPMethod {
        switch self {
        case .companies:
            return .post
        case .search:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .companies:
            return baseURL + "/companies"
        case .search:
            return baseURL + "/search"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .companies(let request):
            return .body(request)
        case .search(let queryRequest, let bodyRequest):
            return .both(queryRequest, bodyRequest)
        }
    }
}
