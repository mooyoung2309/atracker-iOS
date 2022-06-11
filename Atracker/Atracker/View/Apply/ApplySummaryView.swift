//
//  ApplySummaryView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/02.
//

import UIKit

class ApplySummaryView: BaseView {
    let backgroundView = UIView().then {
        $0.backgroundColor = .backgroundLightGray
        $0.layer.cornerRadius = 10
    }
    
    let boxStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    let pieChartView = PieChartView()
    let firstBox = SummaryBoxView(color: .blue6,title: "서류전형", percent: "75%")
    let secondBox = SummaryBoxView(color: .blue4 ,title: "면접전형", percent: "50%")
    let thirdBox = SummaryBoxView(color:.blue2 ,title: "최종전형", percent: "25%")
    
    override func setupProperty() {
        super.setupProperty()
        boxStackView.addArrangedSubviews([firstBox, secondBox, thirdBox])
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(backgroundView)
        backgroundView.addSubview(pieChartView)
        backgroundView.addSubview(boxStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        pieChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(64)
        }
        boxStackView.snp.makeConstraints {
            $0.leading.equalTo(pieChartView.snp.trailing).inset(-25)
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }
}
