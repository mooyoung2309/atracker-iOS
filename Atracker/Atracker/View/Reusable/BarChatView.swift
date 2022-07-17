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
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }

    init(_ axis: NSLayoutConstraint.Axis, cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        
        switch axis {
        case .horizontal:
            self.endPoint = CGPoint(x: 1.0, y: 0.0)
            break
        case .vertical:
            self.endPoint = CGPoint(x: 0.0, y: 1.0)
            break
        default:
            self.endPoint = CGPoint(x: 1.0, y: 0.0)
            break
        }
        
        super.init(frame: .zero)
    }


    override func layoutSubviews() {
        if let _ = gradientLayer { return }
        let gradientLayer           = CAGradientLayer()

        gradientLayer.frame         = self.bounds
        gradientLayer.startPoint    = startPoint
        gradientLayer.endPoint      = endPoint
        
        gradientLayer.cornerRadius  = cornerRadius
        
        gradientLayer.colors        = [UIColor.blue7.cgColor, UIColor.blue6.cgColor, UIColor.blue5.cgColor, UIColor.blue4.cgColor, UIColor.blue3.cgColor, UIColor.blue2.cgColor, UIColor.neonGreen.cgColor]

        layer.addSublayer(gradientLayer)

        self.gradientLayer = gradientLayer
    }
}
