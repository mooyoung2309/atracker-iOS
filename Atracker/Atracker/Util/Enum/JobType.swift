//
//  JobType.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation

enum JobType {
    case fullTime
    case contract
    case intern
    
    var string: String {
        switch self {
        case .fullTime:
            return "정규직"
        case .contract:
            return "계약직"
        case .intern:
            return "인턴"
        }
    }
}
