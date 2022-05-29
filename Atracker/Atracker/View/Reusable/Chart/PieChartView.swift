//
//  PieChartView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit

class PieChartView: UIView {
    
    let colors = [Const.Color.pink, Const.Color.mint, Const.Color.purple, Const.Color.indigo]
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .mainViewColor
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let values: [CGFloat] = [10.0, 20.0, 70.0]
        let total = values.reduce(0, +)
        var startAngle: CGFloat = (-(.pi) / 2)
        var endAngle: CGFloat = 0.0

        for (index, value) in values.enumerated() {
            endAngle = (value / total) * (.pi * 2)

            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: 40, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)

            colors[index].set()
//            path.fill()
            path.close()
            path.lineWidth = 10
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.stroke()
            
            startAngle += endAngle
        }

        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: 30, startAngle: 0, endAngle: .pi * 180, clockwise: true)
        path.lineCapStyle = .round
        UIColor.mainViewColor.set()
//        path.fill()
    }
}
