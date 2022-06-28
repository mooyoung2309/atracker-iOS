//
//  GetApplyQuery.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/28.
//

import Foundation

class GetApplyQuery: Codable {
    let applyIds: [Int]
    let includeContent: Bool
}
