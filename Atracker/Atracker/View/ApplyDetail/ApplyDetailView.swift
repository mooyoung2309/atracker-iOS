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
    let stageTitleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let stageProgressTableView = UITableView()
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
        
        stageTitleCollectionView.register(StageTitleCVC.self, forCellWithReuseIdentifier: StageTitleCVC.id)
        stageTitleCollectionView.backgroundColor = .clear
        stageTitleCollectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        stageTitleCollectionView.collectionViewLayout = layout
        
        stageProgressTableView.register(StageProgressTVC.self, forCellReuseIdentifier: StageProgressTVC.id)
        stageProgressTableView.backgroundColor = .clear
        stageProgressTableView.rowHeight = UITableView.automaticDimension
        stageProgressTableView.estimatedRowHeight = 100
        stageProgressTableView.isScrollEnabled = false
        stageProgressTableView.separatorStyle = .none
        
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
        
        addSubview(stageTitleCollectionView)
        addSubview(scrollView)
        addSubview(editTableView)
        addSubview(tabBarbottomView)
        
        scrollView.addSubview(stageProgressTableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stageTitleCollectionView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(stageTitleCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stageProgressTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(self)
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
