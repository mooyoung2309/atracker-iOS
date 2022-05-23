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
}
