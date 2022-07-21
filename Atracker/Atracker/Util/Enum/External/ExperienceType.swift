//
//  ExperienceType.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/21.
//

import Foundation

enum ExperienceType: String, Codable {
    case notExperienced = "NOT_EXPERIENCED"
    case experienced = "EXPERIENCED"
    
    var title: String {
        switch self {
        case .notExperienced:
            return "신입"
        case .experienced:
            return "경력"
        }
    }
}
