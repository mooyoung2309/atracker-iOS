//
//  ApplyWriteDateView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import UIKit
import SnapKit

class WriteApplyScheduleView: BaseView {
    
    let tableView   = UITableView()
    let nextButton  = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        backgroundColor = .backgroundGray
        
        tableView.register(WriteApplyScheduleTVC.self, forCellReuseIdentifier: WriteApplyScheduleTVC.id)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .gray7
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        nextButton.setTitle("완료", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .normal)
        nextButton.titleLabel?.font     = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor      = .backgroundGray
        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(tableView)
        addSubview(nextButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
