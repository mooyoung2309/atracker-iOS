//
//  AuthRouter.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation
import Alamofire

enum AuthRouter{
    case sign(UserRegistrationRequest)
    case testSign(TestUserRegistrationRequest)
    case testToken(email: String, id: Int)
    case tokenRefresh(TokenRefreshRequest)
}

extension AuthRouter: BaseURLRequestConvertible {
    var baseURL: String {
        return Key.baseURL + "/auth"
    }
    
    var method: HTTPMethod {
        switch self {
        case .sign:
            return .post
        case .testSign:
            return .post
        case .testToken:
            return .post
        case .tokenRefresh:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .sign:
            return baseURL + "/sign"
        case .testSign:
            return baseURL + "/test/sign"
        case .testToken:
            return baseURL + "/test/token"
        case .tokenRefresh:
            return baseURL + "/token/refresh"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .sign(let request):
            return .body(request)
        case .testSign(let request):
            return .body(request)
        case .testToken(let email, let id):
            // TODO: 여기 고쳐야 함 !
            return .query(email)
        case .tokenRefresh(let request):
            return .body(request)
        }
    }
    
    
}
