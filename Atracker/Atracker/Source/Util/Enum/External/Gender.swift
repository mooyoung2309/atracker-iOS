//
//  Gender.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

enum Gender {
    case female
    case male
    
    var code: String {
        switch self {
        case .female:
            return "FEMALE"
        case .male:
            return "MALE"
        }
    }
}
