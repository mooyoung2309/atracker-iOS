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
    
    func addBorders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {

            if edges.contains(.all) {
                layer.borderWidth = width
                layer.borderColor = color.cgColor
            } else {
                let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]

                for edge in allSpecificBorders {
                    if let v = viewWithTag(Int(edge.rawValue)) {
                        v.removeFromSuperview()
                    }

                    if edges.contains(edge) {
                        let v = UIView()
                        v.tag = Int(edge.rawValue)
                        v.backgroundColor = color
                        v.translatesAutoresizingMaskIntoConstraints = false
                        addSubview(v)

                        var horizontalVisualFormat = "H:"
                        var verticalVisualFormat = "V:"

                        switch edge {
                        case UIRectEdge.bottom:
                            horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                            verticalVisualFormat += "[v(\(width))]-(0)-|"
                        case UIRectEdge.top:
                            horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                            verticalVisualFormat += "|-(0)-[v(\(width))]"
                        case UIRectEdge.left:
                            horizontalVisualFormat += "|-(0)-[v(\(width))]"
                            verticalVisualFormat += "|-(0)-[v]-(0)-|"
                        case UIRectEdge.right:
                            horizontalVisualFormat += "[v(\(width))]-(0)-|"
                            verticalVisualFormat += "|-(0)-[v]-(0)-|"
                        default:
                            break
                        }

                        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    }
                }
            }
        }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow(_ edge: UIRectEdge?) {
        if let edge = edge {
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
        } else {
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
            layer.masksToBounds = false
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func concaveEnds(depth: CGFloat) {
            let width = self.bounds.width
            let height = self.bounds.height

            let path = UIBezierPath()
            path.move(to: CGPoint.zero)
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addQuadCurve(to: CGPoint(x: width, y: height), controlPoint: CGPoint(x: width - height * depth, y: height / 2))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addQuadCurve(to: CGPoint.zero, controlPoint: CGPoint(x: height * depth, y: height / 2))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
            self.layer.masksToBounds = false
        }
}

