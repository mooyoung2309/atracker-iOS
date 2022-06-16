//
//  Enum.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import Foundation

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
    case qna    = "질의응답"
    case free   = "종합후기"
    
    var code: String {
        switch self {
        case .qna:
            return "QNA"
        case .free:
            return "FREE_FORM"
        }
    }
}

