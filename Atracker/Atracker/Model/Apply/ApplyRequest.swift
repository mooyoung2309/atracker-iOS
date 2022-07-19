//
//  ApplyReadRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/07.
//

import Foundation

struct ApplyRequest: Codable {
    let applyIds: Int?
    let includeContent: Bool?
}
