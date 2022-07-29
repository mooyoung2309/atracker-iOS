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
    
    let endPoint: CGPoint
    let cornerRadius: CGFloat
    let colors: [UIColor]
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }

    init(axis: NSLayoutConstraint.Axis, cornerRadius: CGFloat, colors: [UIColor]) {
        self.cornerRadius = cornerRadius
        self.colors = colors
        
        switch axis {
        case .horizontal:
            self.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .vertical:
            self.endPoint = CGPoint(x: 0.0, y: 1.0)
        @unknown default:
            fatalError("is old code")
        }
        super.init(frame: .zero)
    }


    override func layoutSubviews() {
        if let _ = gradientLayer { return }
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.colors = colors.map { $0.cgColor }
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }
}
