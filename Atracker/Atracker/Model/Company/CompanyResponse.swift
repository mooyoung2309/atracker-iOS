//
//  CompanyResponse.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Foundation

struct CompanyResponse: Codable {
    let totalCount, currentPageNo, nextPageNo, prevPageNo: Int
    let contentSize: Int
    let first, last: Bool
    let size, remainCount, prevCount: Int
    let hasNext, hasPrev, empty: Bool
    let contents: [Company]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case currentPageNo = "current_page_no"
        case nextPageNo = "next_page_no"
        case prevPageNo = "prev_page_no"
        case contentSize = "content_size"
        case first, last, size
        case remainCount = "remain_count"
        case prevCount = "prev_count"
        case hasNext = "has_next"
        case hasPrev = "has_prev"
        case empty, contents
    }
}
