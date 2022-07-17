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
    
    class var backgroundLightGray: UIColor { UIColor(hex: 0x272A35) }
    class var backgroundGray: UIColor { UIColor(hex: 0x1F2129) }
    class var neonGreen: UIColor { UIColor(hex: 0x37FFDB) }
    class var blue2: UIColor { UIColor(hex: 0x16E9F6) }
    class var blue3: UIColor { UIColor(hex: 0x0ED3FE) }
    class var blue4: UIColor { UIColor(hex: 0x33A9FF) }
    class var blue5: UIColor { UIColor(hex: 0x3C8AFF) }
    class var blue6: UIColor { UIColor(hex: 0x3153FF) }
    class var blue7: UIColor { UIColor(hex: 0x374FEB) }
    class var line: UIColor { UIColor(hex: 0xE9E9E9) }
    class var gray1: UIColor { UIColor(hex: 0xB9BFD3) }
    class var gray2: UIColor { UIColor(hex: 0xA5ABBF) }
    class var gray3: UIColor { UIColor(hex: 0x969CB1) }
    class var gray4: UIColor { UIColor(hex: 0x888EA3) }
    class var gray5: UIColor { UIColor(hex: 0x797F94) }
    class var gray6: UIColor { UIColor(hex: 0x555B70) }
    class var gray7: UIColor { UIColor(hex: 0x40475C) }
    
    class var progressColors: [UIColor] { [UIColor.blue7, UIColor.blue6, UIColor.blue5, UIColor.blue4, UIColor.blue3, UIColor.blue2, UIColor.neonGreen] }
}
