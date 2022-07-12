//
//  ApplyCreateRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation

// MARK: - ApplyCreateRequest
struct ApplyCreateRequest: Codable {
    let company: Company
    let jobPosition, jobType: String
    var stages: [ApplyCreateStage]

    enum CodingKeys: String, CodingKey {
        case company
        case jobPosition = "job_position"
        case jobType = "job_type"
        case stages
    }
}

// MARK: - ApplyCreateStage
struct ApplyCreateStage: Codable {
    var eventAt: String?
    let order, stageID: Int

    enum CodingKeys: String, CodingKey {
        case eventAt = "event_at"
        case order
        case stageID = "stage_id"
    }
    
    mutating func updateEventAt(eventAt: String) {
        self.eventAt = eventAt
    }
}
