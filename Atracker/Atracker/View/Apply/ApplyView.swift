//
//  ApplyView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/01.
//

import UIKit

class ApplyView: BaseView {
    
    let scrollView = UIScrollView()
    let positionLabel = UILabel()
    let titleLabel = UILabel()
    let analysisView = ApplyAnalysisView()
    let applyTableView = UITableView()
    let plusButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        scrollView.showsVerticalScrollIndicator = false
        
        positionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        positionLabel.textColor = .gray1
        
        titleLabel.font = .systemFont(ofSize: 28, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        analysisView.backgroundColor = .backgroundLightGray
        analysisView.layer.cornerRadius = 10
        analysisView.update(data: [10, 20, 30, 40])
        
        applyTableView.register(ApplyTVC.self, forCellReuseIdentifier: ApplyTVC.id)
        applyTableView.isScrollEnabled = false
        applyTableView.backgroundColor = .backgroundLightGray
        applyTableView.separatorStyle = .singleLine
        applyTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        applyTableView.separatorColor = UIColor(hex: 0x292C3F)
        applyTableView.rowHeight = UITableView.automaticDimension
        applyTableView.estimatedRowHeight = 100
        applyTableView.layer.masksToBounds = true
        applyTableView.layer.cornerRadius = 12
        applyTableView.layer.borderWidth = 0
        applyTableView.layer.borderColor = UIColor.backgroundLightGray.cgColor
        
        plusButton.backgroundColor = .gray7
        plusButton.contentHorizontalAlignment = .fill
        plusButton.contentVerticalAlignment = .fill
        plusButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        plusButton.tintColor = .neonGreen
        plusButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        plusButton.layer.shadowColor = UIColor.black.cgColor
        plusButton.layer.shadowOpacity = 0.3
        plusButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        plusButton.layer.shadowRadius = 3
        plusButton.layer.cornerRadius = 20
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        addSubview(plusButton)
        
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(analysisView)
        scrollView.addSubview(applyTableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(36)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(28)
        }
        
        analysisView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-20)
            $0.leading.trailing.equalTo(self).inset(16)
            $0.height.equalTo(90)
        }
        
        applyTableView.snp.makeConstraints {
            $0.top.equalTo(analysisView.snp.bottom).inset(-18)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(0)
            $0.bottom.equalToSuperview()
        }
    }
}
