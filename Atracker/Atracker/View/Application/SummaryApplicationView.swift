//
//  SummaryApplicationStatusView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import Then

class SummaryApplicationView: UIView {
    var pieChartView = PieChartView().then {
        $0.backgroundColor = Const.Color.white
    }
    var firstTitleLabel = UILabel().then {
        $0.text = "1차 면접"
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = Const.Color.black
    }
    var firstValueLabel = UILabel().then {
        $0.text = "89.0%"
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textColor = Const.Color.black
    }
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
        addSubview(firstTitleLabel)
        addSubview(firstValueLabel)
        
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        firstTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pieChartView.widthAnchor.constraint(equalToConstant: 100),
            pieChartView.heightAnchor.constraint(equalToConstant: 100),
            pieChartView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
//            firstTitleLabel.topAnchor.constraint(equalTo: pieChartView.topAnchor, constant: 30),
            firstTitleLabel.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor),
            firstTitleLabel.bottomAnchor.constraint(equalTo: firstValueLabel.topAnchor),
            
            firstValueLabel.leadingAnchor.constraint(equalTo: firstTitleLabel.leadingAnchor),
            firstValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
