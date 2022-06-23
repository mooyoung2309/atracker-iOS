//
//  TokenInterceptor.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Foundation
import Alamofire

class TokenInterceptor {
    static let shared = TokenInterceptor()
    
    private init() {}
    
    func getInterceptor() -> AuthenticationInterceptor<MyAuthenticator> {
        
        let authenticator   = MyAuthenticator()
        let credential      = MyAuthenticationCredential(accessToken: UserDefaults.standard.string(forKey: UserDefaultKey.accessToken) ?? "", refreshToken: UserDefaults.standard.string(forKey: UserDefaultKey.refreshToken) ?? "")
        return AuthenticationInterceptor(authenticator: authenticator, credential: credential)
    }
}
