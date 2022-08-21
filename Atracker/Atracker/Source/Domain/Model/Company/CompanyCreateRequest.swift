//
//  CompanyCreateRequest.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import Foundation

struct CompanyCreateRequest: Codable {
    let name: String
}

typealias CompanyCreateRequests = [CompanyCreateRequest]
