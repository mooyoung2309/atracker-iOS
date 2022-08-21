//
//  TokenRefreshResponse.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

struct TokenRefreshResponse: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
