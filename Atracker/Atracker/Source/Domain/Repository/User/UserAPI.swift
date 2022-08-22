//
//  UserAPI.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/18.
//

import Foundation
import Alamofire

enum UserAPI{
    case id
    case myPage
    case point
    case rank
    case pfratio
}

extension UserAPI: BaseURLRequestConvertible {
    var baseURL: String {
        return Environment.url + "/user"
    }
    
    var method: HTTPMethod {
        switch self {
        case .id:
            return .get
        case .myPage:
            return .get
        case .point:
            return .get
        case .rank:
            return .get
        case .pfratio:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .id:
            return baseURL + "/"
        case .myPage:
            return baseURL + "/mypage"
        case .point:
            return baseURL + "/point"
        case .rank:
            return baseURL + "/rank/point"
        case .pfratio:
            return baseURL + "/statistics/apply/pfratio"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .id:
            return nil
        case .myPage:
            return nil
        case .point:
            return nil
        case .rank:
            return nil
        case .pfratio:
            return nil
        }
    }
}
