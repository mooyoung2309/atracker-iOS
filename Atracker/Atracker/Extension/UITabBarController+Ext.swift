//
//  UITabBarController+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import Foundation
import UIKit

extension UITabBarController {
    func showTabBar() {
        if let customTabBarController = self as? CustomTabBarController {
            customTabBarController.customTabBar.isHidden = false
            Log("탭바 보여짐")
        }
    }
    func hideTabBar() {
        if let customTabBarController = self as? CustomTabBarController {
            customTabBarController.customTabBar.isHidden = true
            Log("탭바 사라짐")
        }
        
    }
}
