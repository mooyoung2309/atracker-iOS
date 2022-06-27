//
//  UIView+Ext.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/23.
//

import UIKit

extension UIView {
    func setupCornerRadius(_ cornerRadius: CGFloat = 0, maskedCorners: CACornerMask? = nil) {
        layer.cornerRadius = cornerRadius
        if let corners = maskedCorners {
            layer.maskedCorners = corners
        }
    }
    
    func animateClick(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in completion() }
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow(_ edge: UIRectEdge) {
        let radius = 2.5

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.1
        
        switch edge {
        case .top:
            layer.shadowOffset = CGSize(width: 0, height: -radius * 2)
        case .bottom:
            layer.shadowOffset = CGSize(width: 0, height: radius * 2)
        case .left:
            layer.shadowOffset = CGSize(width: -radius * 2, height: 0)
        case .right:
            layer.shadowOffset = CGSize(width: radius * 2, height: 0)
        case .all:
            layer.shadowOffset = .zero
        default:
            layer.shadowOffset = .zero
        }
        
        layer.masksToBounds = false
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

