//
//  ProgressStatus.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/12.
//

import Foundation

enum ProgressStatus {
    case inProgress
    case pass
    case fail
    case notStarted
    
    var list: [ProgressStatus] {
        return [ProgressStatus.inProgress, ProgressStatus.pass, ProgressStatus.fail]
    }
    
    var code: String {
        switch self {
        case .inProgress:
            return "IN_PROGRESS"
        case .pass:
            return "PASS"
        case .fail:
            return "FAIL"
        case .notStarted:
            return "NOT_STARTED"
        }
    }
    
    var title: String {
        switch self {
        case .inProgress:
            return "대기중"
        case .pass:
            return "합격"
        case .fail:
            return "불합격"
        case .notStarted:
            return "시작전"
        }
    }
}
