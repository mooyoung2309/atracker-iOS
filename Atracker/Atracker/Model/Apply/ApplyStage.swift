//
//  ApplyStage.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation

// MARK: - ApplyStage
struct ApplyStage: Codable {
    let eventAt: String
    let order, stageID: Int

    enum CodingKeys: String, CodingKey {
        case eventAt = "event_at"
        case order
        case stageID = "stage_id"
    }
}
