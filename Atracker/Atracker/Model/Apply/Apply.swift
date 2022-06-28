//
//  Apply.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let apply = try? newJSONDecoder().decode(Apply.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let apply = try? newJSONDecoder().decode(Apply.self, from: jsonData)

import Foundation

// MARK: - ApplyResponse
struct ApplyResponse: Codable {
    let applyID, companyID: Int
    let companyName, jobPosition: String
    let stageProgress: [StageProgress]

    enum CodingKeys: String, CodingKey {
        case applyID = "apply_id"
        case companyID = "company_id"
        case companyName = "company_name"
        case jobPosition = "job_position"
        case stageProgress = "stage_progress"
    }
}

// MARK: - StageProgress
struct StageProgress: Codable {
    let id: Int
    let title: String
    let stageContent: StageContent
    let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case stageContent = "stage_content"
        case status
    }
}

// MARK: - StageContent
struct StageContent: Codable {
    let contentType: String
    var content: String

    enum CodingKeys: String, CodingKey {
        case content
        case contentType = "content_type"
    }
}
