//
//  HorizontalBarChartView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/19.
//

import UIKit
import Then

class HorizontalBarChartView: UIView {
    let colors: [UIColor] = [.successProgressColor1, .successProgressColor2, .successProgressColor3, .successProgressColor4, .successProgressColor5]
    
    var barStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.backgroundColor = UIColor(hex: 0x353745)
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
        for i in 0..<4 {
            let barView = UIView()
            barView.backgroundColor = colors[i]
            barViews.append(barView)
            barStackView.addArrangedSubview(barView)
        }
    }
    func setView() {
        addSubview(barStackView)
        
        barStackView.translatesAutoresizingMaskIntoConstraints = false
        
        barStackView.layer.cornerRadius = frame.width / 2
        
        NSLayoutConstraint.activate([
            barStackView.topAnchor.constraint(equalTo: topAnchor),
            barStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
