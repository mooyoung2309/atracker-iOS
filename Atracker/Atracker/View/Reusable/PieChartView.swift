//
//  PieChartView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit

class PieChartView: UIView {
    
    let colors: [UIColor] = [.blue6, .blue4, .blue2]
    let data: [Int]
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(data: [Int]) {
        self.data = data
        
        super.init(frame: .zero)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        var arcLayers: [CAShapeLayer] = []
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.height / 2
        var startAngle = -(1.0 / 2.0 * .pi)
        var endAngle = (3.0 / 2.0 * .pi)
        
        layer.addSublayer(makeArcLayer(color: .backgroundGray, withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true))
        
        if data.count != colors.count { return }
        
        for (index, value) in data.enumerated() {
            endAngle = startAngle + Double((value / 100)) * (2 * .pi)
            arcLayers.append(makeArcLayer(color: colors[index], withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true))
            startAngle = endAngle
        }
        
        arcLayers.reversed().forEach({ layer.addSublayer($0) })
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
    }
}
