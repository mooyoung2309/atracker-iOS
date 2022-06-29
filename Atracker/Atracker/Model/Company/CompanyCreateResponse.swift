//
//  CompanyCreateResponse.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/30.
//

import Foundation

// MARK: - CompanyCreateResponse
struct CompanyCreateResponse: Codable {
    let companies: [Company]
}

// MARK: - CreatedCompany
struct Company: Codable {
    let id: Int
    let name: String
}
