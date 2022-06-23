//
//  CompanySearchCondition.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Foundation

struct CompanySearchCondition: Codable {
    let title: String
    let userDefined: Bool

    enum CodingKeys: String, CodingKey {
        case title
        case userDefined = "user_defined"
    }
}
