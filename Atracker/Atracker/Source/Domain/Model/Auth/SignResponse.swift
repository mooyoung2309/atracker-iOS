//
//  SignResponse.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

struct SignResponse: Codable {
    let accessToken, refreshToken: String
    let message: String?
    let status: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case message
        case refreshToken = "refresh_token"
        case status
    }
}
