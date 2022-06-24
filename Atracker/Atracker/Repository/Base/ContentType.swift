//
//  ContentType.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/22.
//

import Foundation

enum ContentType {
    case json
    
    var code: String {
        switch self {
        case .json:
            return "application/json"
        }
    }
}
