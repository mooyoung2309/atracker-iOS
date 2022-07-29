//
//  ApplyUpdateRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/19.
//

import Foundation

// MARK: - ApplyUpdateRequest
struct ApplyUpdateRequest: Codable {
    let applyID: Int
    let company: Company
    let jobPosition, jobType: String
    let stages: [UpdateStage]

    enum CodingKeys: String, CodingKey {
        case applyID = "apply_id"
        case company
        case jobPosition = "job_position"
        case jobType = "job_type"
        case stages
    }
}

// MARK: - Stage
struct UpdateStage: Codable {
    let eventAt: String?
    let order, stageID: Int

    enum CodingKeys: String, CodingKey {
        case eventAt = "event_at"
        case order
        case stageID = "stage_id"
    }
}
