//
//  JobType.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation

enum JobType {
    case permanent
    case temporary
    case intern
    
    static var elements: [JobType] = [JobType.permanent, JobType.temporary, JobType.intern]
    
    static func toJobType(title: String) -> JobType {
        switch title {
        case JobType.permanent.title:
            return JobType.permanent
        case JobType.temporary.title:
            return JobType.temporary
        case JobType.intern.title:
            return JobType.intern
        default:
            return JobType.intern
        }
    }
    
    var code: String {
        switch self {
        case .permanent:
            return "PERMANENT"
        case .temporary:
            return "TEMPORARY"
        case .intern:
            return "INTERN"
        }
    }
    
    var title: String {
        switch self {
        case .permanent:
            return "정규직"
        case .temporary:
            return "계약직"
        case .intern:
            return "인턴"
        }
    }
}
