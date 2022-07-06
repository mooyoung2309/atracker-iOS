//
//  Stage.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import Foundation

// MARK: - StageResponse
typealias StageResponse = [Stage]

struct Stage: Codable {
    let id: Int
    let title: String
}
