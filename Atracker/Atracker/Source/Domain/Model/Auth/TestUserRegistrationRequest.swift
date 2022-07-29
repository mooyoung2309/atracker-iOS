//
//  TestUserRegistrationRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

struct TestUserRegistrationRequest: Codable {
    let email, gender, jobPosition, nickName: String
    let sso: String

    enum CodingKeys: String, CodingKey {
        case email, gender
        case jobPosition = "job_position"
        case nickName = "nick_name"
        case sso
    }
}
