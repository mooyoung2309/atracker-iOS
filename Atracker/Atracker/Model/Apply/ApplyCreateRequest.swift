//
//  ApplyCreateRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation

// MARK: - ApplyCreateRequest
struct ApplyCreateRequest: Codable {
    let company: AppliedCompanyInfo
    let jobPosition: String
    let stages: [ApplyStage]

    enum CodingKeys: String, CodingKey {
        case company
        case jobPosition = "job_position"
        case stages
    }
}
