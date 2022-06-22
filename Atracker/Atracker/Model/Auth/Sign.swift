//
//  Auth.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sign = try? newJSONDecoder().decode(Sign.self, from: jsonData)

import Foundation

// MARK: - Sign
struct Sign: Codable {
    let email, gender, jobPosition, nickName: String
    let sso: String

    enum CodingKeys: String, CodingKey {
        case email, gender
        case jobPosition = "job_position"
        case nickName = "nick_name"
        case sso
    }
}
