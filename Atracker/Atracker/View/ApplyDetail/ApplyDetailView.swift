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
    
    let barChartView    = BarChatView()
    let dateLabel       = UILabel()
    let tableView       = UITableView()
    
    override func setupProperty() {
        super.setupProperty()
        
        dateLabel.text = "2022.06.12"
        dateLabel.font = .systemFont(ofSize: 15, weight: .bold)
        dateLabel.textColor = .gray2
        
        tableView.register(ApplyDetailTVC.self, forCellReuseIdentifier: ApplyDetailTVC.id)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(barChartView)
        addSubview(dateLabel)
        addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(barChartView.snp.bottom).inset(-13)
            $0.leading.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(18)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
