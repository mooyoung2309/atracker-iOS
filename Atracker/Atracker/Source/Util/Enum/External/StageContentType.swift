//
//  ContentType.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation

enum StageContentType {
    case OVERALL
    case QNA
    case FREE
    
    var code: String {
        switch self {
        case .OVERALL:
            return "NOT_DEFINED"
        case .QNA:
            return "QNA"
        case .FREE:
            return "FREE_FORM"
        }
    }
    
    var title: String {
        switch self {
        case .OVERALL:
            return "종합"
        case .QNA:
            return "질의응답"
        case .FREE:
            return "종합후기"
        }
    }
}
