//
//  AuthCredential.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Alamofire
import Foundation

struct MyAuthenticationCredential: AuthenticationCredential {
    let accessToken: String
    let refreshToken: String
    
    var requiresRefresh = false
}
