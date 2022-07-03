//
//  Enum.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import Foundation
import UIKit

enum TabBarItem: String {
    case blog   = "블로그"
    case apply  = "지원 현황"
    case plan   = "일정"
}

enum StageProgressStatus: String {
    case notStarted = "대기중"
    case fail       = "불합격"
    case pass       = "합격"
    
    var code: String {
        switch self {
        case .notStarted:
            return "NOT_STARTED"
        case .fail:
            return "FAIL"
        case .pass:
            return "PASS"
        }
    }
}

enum StageContentType: String {
    case OVERALL = "종합"
    case QNA = "질의응답"
    case FREE = "종합후기"
    
    var code: String {
        switch self {
        case .OVERALL:
            return "OVERALL"
        case .QNA:
            return "QNA"
        case .FREE:
            return "FREE_FORM"
        }
    }
}
