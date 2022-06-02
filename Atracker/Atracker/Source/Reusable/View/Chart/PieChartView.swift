//
//  PieChartView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit

class PieChartView: UIView {
    
    let colors: [UIColor] = [.blue6, .blue4, .blue2]
    let mokUps: [CGFloat] = [50.0, 7.0, 20.0]
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        var arcLayers: [CAShapeLayer] = []
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.height / 2
        var startAngle = -(1.0 / 2.0 * .pi)
        var endAngle = (3.0 / 2.0 * .pi)
        
        layer.addSublayer(makeArcLayer(color: .backgroundGray, withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true))
        
        for (index, value) in mokUps.enumerated() {
            endAngle = startAngle + (value / 100) * (2 * .pi)
            arcLayers.append(makeArcLayer(color: colors[index], withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true))
            startAngle = endAngle
        }
        
        arcLayers.reversed().forEach({ layer.addSublayer($0) })
    }
    
    override func layoutSubviews() {
//        let rect = self.bounds
        
//        backgroundColor = .clear
//        var arcLayers: [CAShapeLayer] = []
//
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        let radius = rect.height / 2
//        var startAngle = -(1.0 / 2.0 * .pi)
//        var endAngle = (3.0 / 2.0 * .pi)
//
//        layer.addSublayer(makeArcLayer(color: .backgroundGray, withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true))
//
//        for (index, value) in mokUps.enumerated() {
//            endAngle = startAngle + (value / 100) * (2 * .pi)
//            arcLayers.append(makeArcLayer(color: colors[index], withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true))
//            startAngle = endAngle
//        }
//
//        arcLayers.reversed().forEach({ layer.addSublayer($0) })
    }
    
    func makeArcLayer(color: UIColor, withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> CAShapeLayer {
        let arcPath = UIBezierPath()
        arcPath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        let arcLayer = CAShapeLayer()
        arcLayer.path = arcPath.cgPath
        arcLayer.lineWidth = 8
        arcLayer.lineCap = .round
        arcLayer.strokeColor = color.cgColor
        arcLayer.fillColor = UIColor.clear.cgColor
        
        return arcLayer
//        arcLayer.fillMode = .forwards
        
//        layer.addSublayer(arcLayer)
    }
        
//        backgroundColor = .mainViewColor
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        let total = mokUps.reduce(0, +)
//        var startAngle: CGFloat = (-(.pi) / 2)
//        var endAngle: CGFloat = 0.0
//
//        for (index, value) in values.enumerated() {
//            endAngle = (value / total) * (.pi * 2)
//
//            let path = UIBezierPath()
//            path.move(to: center)
//            path.addArc(withCenter: center, radius: 40, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
//
//            colors[index].set()
////            path.fill()
//            path.close()
//            path.lineWidth = 10
//            path.lineCapStyle = .round
//            path.lineJoinStyle = .round
//            path.stroke()
//
//            startAngle += endAngle
//        }
//
//        let path = UIBezierPath()
//        path.addArc(withCenter: center, radius: 30, startAngle: 0, endAngle: .pi * 180, clockwise: true)
//        path.lineCapStyle = .round
//        UIColor.mainViewColor.set()
////        path.fill()
//    }
}
