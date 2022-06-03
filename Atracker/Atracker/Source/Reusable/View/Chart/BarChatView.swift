//
//  BarChatView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit

class BarChatView: UIView {
    var gradientLayer: CAGradientLayer!

    override func layoutSubviews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.blue7.cgColor, UIColor.blue6.cgColor, UIColor.blue5.cgColor, UIColor.blue4.cgColor, UIColor.blue3.cgColor, UIColor.blue2.cgColor, UIColor.neonGreen.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 5
        layer.addSublayer(gradientLayer)
    }
}
