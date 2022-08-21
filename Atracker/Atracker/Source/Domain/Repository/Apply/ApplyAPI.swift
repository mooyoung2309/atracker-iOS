//
//  ApplyAPI.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation
import Alamofire

enum ApplyAPI {
    case get(ApplyRequest)
    case post(ApplyCreateRequest)
    case put(ApplyUpdateRequest)
    case delete(ApplyDeleteRequest)
}

extension ApplyAPI: BaseURLRequestConvertible {
    var baseURL: String {
        return Key.baseURL + "/apply/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .get:
            return baseURL
        case .post:
            return baseURL
        case .put:
            return baseURL
        case .delete:
            return baseURL + "applies/"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .get(let request):
            return .query(request)
        case .post(let request):
            return .body(request)
        case .put(let request):
            return .body(request)
        case .delete(let request):
            return .query(request)
        }
    }
}
