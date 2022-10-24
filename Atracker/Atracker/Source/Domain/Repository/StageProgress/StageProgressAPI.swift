//
//  StageProgressAPI.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import Alamofire

enum StageProgressAPI {
    case put(StageProgressUpdateRequest)
    case delete(StageProgressDeleteRequest)
}

extension StageProgressAPI: API {
    var baseURL: String {
        return Environment.url + "/stageProgress/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .put(_):
            return .put
        case .delete(_):
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .put(_):
            return baseURL
        case .delete(_):
            return baseURL + "stageProgresses"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .put(let stageProgressUpdateRequest):
            return .body(stageProgressUpdateRequest)
        case .delete(let stageProgressDeleteRequest):
            return .query(stageProgressDeleteRequest)
        }
    }
}
