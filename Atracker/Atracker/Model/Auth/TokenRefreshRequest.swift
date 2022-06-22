//
//  TokenRefreshRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

struct TokenRefreshRequest: Codable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
