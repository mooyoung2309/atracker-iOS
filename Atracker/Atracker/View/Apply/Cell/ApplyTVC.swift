//
//  ApplyTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/12.
//

import UIKit
import SnapKit

class ApplyTVC: BaseTVC {
    static let id = "ApplyTVC"
    
    let companyLabel = UILabel()
    let positionLabel = UILabel()
    let barChartView = ProgressBarView()
    
    func update(apply: Apply) {
        companyLabel.text = apply.companyName
        
        positionLabel.text = apply.jobPosition
        
        let totalCount = apply.stageProgress.count
        let failCount = apply.stageProgress.filter({ $0.status == ProgressStatus.fail.code }).count
        let passCount = apply.stageProgress.filter({ $0.status == ProgressStatus.pass.code }).count
        let notStartedCount = apply.stageProgress.filter({ $0.status == ProgressStatus.notStarted.code }).count
        
        barChartView.update(total: totalCount, part: notStartedCount + passCount)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .backgroundLightGray
        
        companyLabel.font = .systemFont(ofSize: 16, weight: .regular)
        companyLabel.textColor = .white
        
        positionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        positionLabel.textColor = .gray1
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
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(24)
            $0.height.equalTo(10)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
