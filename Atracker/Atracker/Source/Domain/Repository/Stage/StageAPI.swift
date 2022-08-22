//
//  StageAPI.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/06.
//

import Foundation
import Alamofire

enum StageAPI {
    case get
    case post(StageCreateRequest)
}

extension StageAPI: BaseURLRequestConvertible {
    var baseURL: String {
        return Environment.url + "/stage/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post(_):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .get:
            return baseURL
        case .post(_):
            return baseURL
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .get:
            return nil
        case .post(let stageCreateRequest):
            return .body(stageCreateRequest)
        }
    }
}
