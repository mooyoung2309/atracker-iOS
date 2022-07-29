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
    let progressBarView = UIView()
    let dividerStackView = UIStackView()
    var progressBar = UIView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        companyLabel.text = ""
        positionLabel.text = ""
        progressBar.removeFromSuperview()
        dividerStackView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func update(apply: Apply) {
        let totalCount = apply.stageProgress.count
        let failCount = apply.stageProgress.filter({ $0.status == ProgressStatus.fail.code }).count
        let notStartedCount = apply.stageProgress.filter({ $0.status == ProgressStatus.notStarted.code }).count
        let passCount = totalCount - failCount - notStartedCount
        
        companyLabel.text = apply.companyName
        
        positionLabel.text = apply.jobPosition
        
        if failCount > 0 {
            progressBar = BarChatView(axis: .horizontal, cornerRadius: 5, colors: UIColor.failColors)
        } else {
            progressBar = BarChatView(axis: .horizontal, cornerRadius: 5, colors: UIColor.passColors)
        }
        
        progressBarView.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(CGFloat(passCount) / CGFloat(totalCount))
        }
        
        for i in 0...totalCount {
            let divider = UIView()
            
            divider.backgroundColor = .backgroundGray
            if i == 0 || i == totalCount {
                divider.backgroundColor = .clear
            }
            divider.snp.makeConstraints {
                $0.width.equalTo(1)
            }
            dividerStackView.addArrangedSubview(divider)
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .backgroundLightGray
        
        companyLabel.font = .systemFont(ofSize: 16, weight: .regular)
        companyLabel.textColor = .white
        
        positionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        positionLabel.textColor = .gray1
        
        progressBarView.backgroundColor = .backgroundGray
        progressBarView.layer.cornerRadius = 5
        
        dividerStackView.axis = .horizontal
        dividerStackView.distribution = .equalSpacing
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews(companyLabel, positionLabel, progressBarView, dividerStackView)
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
        
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(companyLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(10)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        dividerStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(progressBarView)
        }
    }
}
