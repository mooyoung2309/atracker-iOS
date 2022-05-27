//
//  SummaryApplicationStatusView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then

class SummaryApplicationView: UIView {
    let pieChartView = PieChartView().then {
        $0.backgroundColor = .mainViewColor
    }
    let boxStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    let firstBox = SummaryBoxView(title: "서류", content: "82%")
    let secondBox = SummaryBoxView(title: "1차 면접", content: "36%")
    let thirdBox = SummaryBoxView(title: "2차 면접", content: "19%")
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    init() {
        super.init(frame: .zero)
        setView()
    }
}

extension SummaryApplicationView {
    func setView() {
        
        
        addSubview(pieChartView)
        addSubview(boxStackView)
        
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        boxStackView.translatesAutoresizingMaskIntoConstraints = false
        
        boxStackView.addArrangedSubview(firstBox)
        boxStackView.addArrangedSubview(secondBox)
        boxStackView.addArrangedSubview(thirdBox)
        
        NSLayoutConstraint.activate([
            pieChartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pieChartView.widthAnchor.constraint(equalToConstant: 100),
            pieChartView.heightAnchor.constraint(equalToConstant: 100),
            pieChartView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            boxStackView.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            boxStackView.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor, constant: 0),
            boxStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            boxStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}
