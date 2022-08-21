//
//  AgreementType.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/21.
//

import Foundation
import UIKit

enum AgreementType {
    case all
    case service
    case personal
    case marketing
    
    var title: String {
        switch self {
        case .all:
            return "약관 전체동의"
        case .service:
            return "(필수) 서비스 이용약관"
        case .personal:
            return "(필수) 개인정보 처리방침"
        case .marketing:
            return "(선택) 마케팅 정보 수신 동의"
        }
    }
    
    var url: String? {
        switch self {
        case .all:
            return nil
        case .service:
            return "https://atracker-web.netlify.app/terms/user"
        case .personal:
            return "https://atracker-web.netlify.app/terms/"
        case .marketing:
            return "https://atracker-web.netlify.app/terms/user"
        }
    }
    
    var dividerColor: UIColor {
        switch self {
        case .all:
            return .gray7
        case .service:
            return .backgroundLightGray
        case .personal:
            return .backgroundLightGray
        case .marketing:
            return .backgroundLightGray
        }
    }
    
    var titleFont: UIFont {
        switch self {
        case .all:
            return .systemFont(ofSize: 16, weight: .medium)
        case .service:
            return .systemFont(ofSize: 16, weight: .light)
        case .personal:
            return .systemFont(ofSize: 16, weight: .light)
        case .marketing:
            return .systemFont(ofSize: 16, weight: .light)
        }
    }
}
