//
//  ApplyAPI.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation
import Alamofire

enum ApplyAPI {
    case getApply(ApplyRequest)
    case postApply(ApplyCreateRequest)
}

extension ApplyAPI: BaseURLRequestConvertible {
    var baseURL: String {
        return Key.baseURL + "/apply"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getApply:
            return .get
        case .postApply:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getApply:
            return baseURL
        case .postApply:
            return baseURL
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .getApply(let getApplyQuery):
            return .query(getApplyQuery)
        case .postApply(let applyCreateRequest):
            return .body(applyCreateRequest)
        }
    }
}
