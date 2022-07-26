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

import Foundation

// MARK: - ApplyResponse
struct ApplyResponse: Codable {
    let applies: [Apply]
}

// MARK: - Apply
struct Apply: Codable {
    let applyID: Int
    let jobPosition, jobType: String
    let companyID: Int
    let companyName: String
    var stageProgress: [StageProgress]

    enum CodingKeys: String, CodingKey {
        case applyID = "apply_id"
        case jobPosition = "job_position"
        case jobType = "job_type"
        case companyID = "company_id"
        case companyName = "company_name"
        case stageProgress = "stage_progress"
    }
}

// MARK: - StageProgress
struct StageProgress: Codable {
    let id: Int
    var status: String
    let order: Int
    var stageContents: [StageContent]
    var eventAt: String?
    let stageID: Int
    let stageTitle: String

    enum CodingKeys: String, CodingKey {
        case id, status, order
        case stageContents = "stage_contents"
        case eventAt = "event_at"
        case stageID = "stage_id"
        case stageTitle = "stage_title"
    }
}

// MARK: - StageContent
struct StageContent: Codable {
    let id: Int
    var order: Int
    var content: String?
    let contentType: String?
    
    enum CodingKeys: String, CodingKey {
        case id, order, content
        case contentType = "content_type"
    }
}
