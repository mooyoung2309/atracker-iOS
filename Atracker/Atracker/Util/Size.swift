//
//  Size.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/10.
//

import Foundation
import UIKit

struct Size {
    static let screenHeight         = UIScreen.main.bounds.height
    static let screenWidth          = UIScreen.main.bounds.width
    static let statusBarHeight      = 44.0
    static let navigationBarHeight  = 44.0
    static let tabBarHeight         = 80.0
    
    static let calendarWidth        = ((Size.screenWidth - 1) / 7.0) * 7.0
    static let calendarHeight       = (Size.screenHeight) * 0.3
    
    static let companySearchTableViewMaxHeight = 330.0
}
