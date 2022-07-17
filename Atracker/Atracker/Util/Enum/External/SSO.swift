//
//  Sso.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

enum SSO {
    case apple
    case google
    
    var code: String {
        switch self {
        case .apple:
            return "APPLE"
        case .google:
            return "GOOGLE"
        }
    }
}
