//
//  UITextView+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/25.
//

import UIKit

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
