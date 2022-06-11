//
//  UIStackView+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
    func thide() {
        self.arrangedSubviews.forEach {
            $0.isHidden = true
            $0.alpha = 0
        }
    }
    
    func tshow() {
        self.arrangedSubviews.forEach {
            $0.isHidden = false
            $0.alpha = 1
        }
    }
}
