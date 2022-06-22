//
//  UserRegistrationRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

struct UserRegistrationRequest: Codable {
    let accessToken, gender, jobPosition, nickName: String
    let sso: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case gender
        case jobPosition = "job_position"
        case nickName = "nick_name"
        case sso
    }
}
