//
//  StageCreateRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/07.
//

import Foundation

// MARK: - StageCreateRequest
typealias StageCreateRequest = [StageCreate]

struct StageCreate: Codable {
    let stageCreateDefault: Bool
    let title: String

    enum CodingKeys: String, CodingKey {
        case stageCreateDefault = "default"
        case title
    }
}
