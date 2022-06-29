//
//  BarChatView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit

class BarChatView: UIView {

    var gradientLayer: CAGradientLayer?
    let startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var endPoint: CGPoint!

    required init?(coder: NSCoder) {
        endPoint = CGPoint(x: 1.0, y: 0.0)
        super.init(coder: coder)
    }

    init(_ axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        switch axis {
        case .horizontal:
            endPoint = CGPoint(x: 1.0, y: 0.0)
            return
        case .vertical:
            endPoint = CGPoint(x: 0.0, y: 1.0)
            return
        default:
            return
        }
    }


    override func layoutSubviews() {
        if let _ = gradientLayer { return }
        let gradientLayer           = CAGradientLayer()

        gradientLayer.frame         = self.bounds
        gradientLayer.startPoint    = startPoint
        gradientLayer.endPoint      = endPoint
//        gradientLayer.cornerRadius  = 5
        gradientLayer.colors        = [UIColor.blue7.cgColor, UIColor.blue6.cgColor, UIColor.blue5.cgColor, UIColor.blue4.cgColor, UIColor.blue3.cgColor, UIColor.blue2.cgColor, UIColor.neonGreen.cgColor]

        layer.addSublayer(gradientLayer)

        self.gradientLayer = gradientLayer
    }
}
