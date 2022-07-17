//
//  ProgressStatus.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/12.
//

import Foundation

enum ProgressStatus {
    case notStarted
    case pass
    case fail
    
    var list: [ProgressStatus] {
        return [ProgressStatus.notStarted, ProgressStatus.pass, ProgressStatus.fail]
    }
    
    var code: String {
        switch self {
        case .notStarted:
            return "NOT_STARTED"
        case .pass:
            return "PASS"
        case .fail:
            return "FAIL"
        }
    }
    
    var title: String {
        switch self {
        case .notStarted:
            return "대기중"
        case .pass:
            return "합격"
        case .fail:
            return "불합격"
        }
    }
}
