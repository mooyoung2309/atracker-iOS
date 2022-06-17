//
//  ApplyDetailView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/11.
//

import UIKit
import SnapKit
import Then

class ApplyDetailView: BaseView {
    
    let scrollView      = UIScrollView()
    let hChartView      = BarChatView(.horizontal)
    let dateLabel       = UILabel()
    let vChartView      = BarChatView(.vertical)
    let tableView       = UITableView()
    let editButton      = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        scrollView.showsVerticalScrollIndicator = false
        
        dateLabel.text      = "2022.06.12"
        dateLabel.font      = .systemFont(ofSize: 15, weight: .bold)
        dateLabel.textColor = .gray2
        
        tableView.register(ApplyDetailTVC.self, forCellReuseIdentifier: ApplyDetailTVC.id)
        tableView.backgroundColor       = .clear
        tableView.rowHeight             = UITableView.automaticDimension
        tableView.estimatedRowHeight    = 100
        tableView.isScrollEnabled       = false
        tableView.separatorStyle        = .singleLine
        tableView.separatorInset        = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.separatorColor        = .gray2
        
        editButton.setTitle("편집", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        scrollView.addSubview(hChartView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(editButton)
        scrollView.addSubview(vChartView)
        scrollView.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        hChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(28)
            $0.height.equalTo(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(hChartView.snp.bottom).inset(-13)
            $0.leading.equalTo(hChartView)
        }
        
        editButton.snp.makeConstraints {
            $0.trailing.equalTo(hChartView)
            $0.centerY.equalTo(dateLabel)
        }
        
        vChartView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.bottom.equalTo(tableView)
            $0.width.equalTo(2)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(vChartView)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().inset(10)
            $0.height.equalTo(0)
        }
    }
}
