//
//  Enviroment.swift
//  Atracker
//
//  Created by 송영모 on 2022/08/22.
//

import Foundation

struct Environment {
    static let url: String = Bundle.main.object(forInfoDictionaryKey: "SERVER_HOST") as? String ?? ""
    
    static let googleClientID: String = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_CLIENT_ID") as? String ?? ""
}
