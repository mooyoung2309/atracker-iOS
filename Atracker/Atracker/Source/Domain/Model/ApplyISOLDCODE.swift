//
//  Apply.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/29.
//

import Foundation

struct ApplyZipISOLDCODE {
    var applyType: String
    var applies: [ApplyISOLDCODE]
    
    mutating func updateIsEditing(bool: Bool) {
        for i in 0..<applies.count {
            self.applies[i].isEditing = bool
        }
    }
    
    mutating func updateIsChecked(bool: Bool) {
        for i in 0..<applies.count {
            self.applies[i].isChecked = bool
        }
    }
}

struct ApplyISOLDCODE {
    var isEditing: Bool = false
    var isChecked: Bool = false
    var type: String
    var content: String
}
