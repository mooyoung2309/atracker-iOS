//
//  Apply.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/29.
//

import Foundation

struct ApplyZip {
    var applyType: String
    var applies: [Apply]
}

struct Apply {
    var isChecked: Bool = false
    var type: String
    var content: String
}
