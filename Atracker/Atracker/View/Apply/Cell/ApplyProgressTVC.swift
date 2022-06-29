//
//  ApplyProgressTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit

class ApplyProgressTVC: BaseTVC {
    static let id = "ApplyProgressTVC"
    
    var companyLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15, weight: .bold)
    }
    var positionLabel = UILabel().then {
        $0.textColor = .contentGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
    }
    var barChartView = ProgressBarView()
    
    func update(apply: ApplyResponse) {
        companyLabel.text = apply.companyName
        positionLabel.text = apply.jobPosition
        
        barChartView.update(total: 5, part: 3)
    }
    
    override func setupProperty() {
        super.setupProperty()
        backgroundColor = .backgroundLightGray
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        contentView.addSubview(companyLabel)
        contentView.addSubview(positionLabel)
        contentView.addSubview(barChartView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        companyLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        positionLabel.snp.makeConstraints {
            $0.centerY.equalTo(companyLabel)
            $0.leading.equalTo(companyLabel.snp.trailing).inset(-8)
        }
        barChartView.snp.makeConstraints {
            $0.top.equalTo(companyLabel.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(10)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
