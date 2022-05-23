//
//  UIColor+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainBackGroundColor: UIColor { UIColor(hex: 0x292C3F) }
    class var mainViewColor: UIColor { UIColor(hex: 0x393F54) }
    class var contentGray: UIColor { UIColor(hex: 0x949494) }
    class var successProgressColor1: UIColor { UIColor(hex: 0x374FEB) }
    class var successProgressColor2: UIColor { UIColor(hex: 0x4A88FF) }
    class var successProgressColor3: UIColor { UIColor(hex: 0x3FAEFF) }
    class var successProgressColor4: UIColor { UIColor(hex: 0x07D2FF) }
    class var successProgressColor5: UIColor { UIColor(hex: 0x37FFDB) }
}
