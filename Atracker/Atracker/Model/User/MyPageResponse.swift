//
//  MyPage.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/18.
//

import Foundation

// MARK: - MyPage
struct MyPageResponse: Codable {
    let email, jobPosition, nickName: String
    let experienceType: ExperienceType
    let point: Int

    enum CodingKeys: String, CodingKey {
        case email
        case jobPosition = "job_position"
        case nickName = "nick_name"
        case experienceType = "experience_type"
        case point
    }
}
