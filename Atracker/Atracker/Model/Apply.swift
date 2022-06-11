//
//  Apply.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

struct Apply: Codable {
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

struct StageProgress: Codable {
    let content: String
    let id: Int
    let status: String
}

typealias Applies = [Apply]
