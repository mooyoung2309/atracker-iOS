//
//  ApplyEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/30.
//

import UIKit
import SnapKit

class ApplyEditView: BaseView {
    
    let scrollView              = UIScrollView()
    let collectionView          = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout())
    let dividerView             = UIView()
    let tableView               = UITableView()
    let stageStatusButtonBar    = StageStatusButtonBar()
    let reviewDeleteButtonBar   = ReviewDeleteButtonBar()
    
    override func setupProperty() {
        super.setupProperty()
        
        scrollView.showsVerticalScrollIndicator = false
        
        collectionView.register(StageTitleCVC.self, forCellWithReuseIdentifier: StageTitleCVC.id)
        collectionView.backgroundColor                  = .clear
        collectionView.showsHorizontalScrollIndicator   = false
        let layout                                      = UICollectionViewFlowLayout()
        layout.scrollDirection                          = .horizontal
        collectionView.collectionViewLayout             = layout
        
        dividerView.backgroundColor = .gray7
        
        tableView.register(ReviewEditTVC.self, forCellReuseIdentifier: ReviewEditTVC.id)
        tableView.backgroundColor                       = .clear
        tableView.rowHeight                             = UITableView.automaticDimension
        tableView.estimatedRowHeight                    = 600
        tableView.isScrollEnabled                       = false
        tableView.showsVerticalScrollIndicator          = false
        
        reviewDeleteButtonBar.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(collectionView)
        addSubview(dividerView)
        addSubview(stageStatusButtonBar)
        addSubview(reviewDeleteButtonBar)
        addSubview(scrollView)
        scrollView.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        stageStatusButtonBar.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).inset(-15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
        
        reviewDeleteButtonBar.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).inset(-15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(stageStatusButtonBar.snp.bottom).inset(-17)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(0)
        }
        
//        plusButtonStackView.snp.makeConstraints {
//            $0.top.equalTo(tableView.snp.bottom)
//            $0.leading.equalToSuperview().inset(16)
//            $0.trailing.equalToSuperview().inset(-16)
//            $0.bottom.equalToSuperview()
//        }
    }
}
