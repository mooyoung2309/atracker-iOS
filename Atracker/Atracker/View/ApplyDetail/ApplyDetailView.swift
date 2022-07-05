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
    
    let scrollView = UIScrollView()
    let hChartView = BarChatView(.horizontal, cornerRadius: 5)
    let tableView = UITableView()
    let editTableView = UITableView()
    let tabBarbottomView = UIView()
    
    func showEditTableView() {
        editTableView.isHidden = false
        tabBarbottomView.isHidden = false
    }
    
    func hideEditTableView() {
        editTableView.isHidden = true
        tabBarbottomView.isHidden = true
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        scrollView.showsVerticalScrollIndicator = false
        
        tableView.register(ApplyDetailTVC.self, forCellReuseIdentifier: ApplyDetailTVC.id)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        editTableView.register(EditTypeTVC.self, forCellReuseIdentifier: EditTypeTVC.id)
        editTableView.backgroundColor = .clear
        editTableView.rowHeight = UITableView.automaticDimension
        editTableView.estimatedRowHeight = 100
        editTableView.isScrollEnabled = false
        
        tabBarbottomView.backgroundColor = .backgroundLightGray
        
        hideEditTableView()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        addSubview(editTableView)
        addSubview(tabBarbottomView)
        
        scrollView.addSubview(hChartView)
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(hChartView.snp.bottom)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        editTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tabBarbottomView.snp.top)
            $0.height.equalTo(0)
        }
        
        tabBarbottomView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
}
