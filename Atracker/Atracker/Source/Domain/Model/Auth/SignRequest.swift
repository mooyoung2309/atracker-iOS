//
//  SignRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/21.
//

import Foundation

// MARK: - ApplyResponse
struct SignRequest: Codable {
    let accessToken, jobPosition, nickName: String
    let experienceType: ExperienceType
    let sso: SSO

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case experienceType = "experience_type"
        case jobPosition = "job_position"
        case nickName = "nick_name"
        case sso
    }
}
