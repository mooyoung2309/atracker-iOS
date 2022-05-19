//
//  HorizontalBarChartView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import Then

class HorizontalBarChartView: UIView {
    let colors: [UIColor] = [Const.Color.orange, Const.Color.purple, Const.Color.mint, Const.Color.indigo, Const.Color.green, Const.Color.darkGray]
    
    var barStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    var barViews: [UIView] = []
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        setBarStackView()
    }
    
    init() {
        super.init(frame: .zero)
        setView()
        setBarStackView()
    }
}

extension HorizontalBarChartView {
    func setBarStackView() {
        for i in 0..<5 {
            let barView = UIView()
            barView.backgroundColor = colors[i]
            barViews.append(barView)
            barStackView.addArrangedSubview(barView)
        }
        
    }
    func setView() {
        addSubview(barStackView)
        
        barStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barStackView.topAnchor.constraint(equalTo: topAnchor),
            barStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
