//
//  EditApplyStageProgressView.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/13.
//

import Foundation
import UIKit

class EditApplyStageProgressView: BaseView {
    
    let scrollView = UIScrollView()
    let stageTitleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let editProgressTableView = UITableView()
    let statusButtonBar = StageStatusButtonBar()
    let deleteButtonBar = ReviewDeleteButtonBar()
    let addButtonStackView = UIStackView()
    let addQNAContentButton = UIButton(type: .system)
    let addFreeContentButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        scrollView.showsVerticalScrollIndicator = false
        
        stageTitleCollectionView.register(StageTitleCVC.self, forCellWithReuseIdentifier: StageTitleCVC.id)
        stageTitleCollectionView.backgroundColor = .clear
        stageTitleCollectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        stageTitleCollectionView.collectionViewLayout = layout
        
        editProgressTableView.register(EditQNAContentTVC.self, forCellReuseIdentifier: EditQNAContentTVC.id)
        editProgressTableView.register(EditOVERALLContentTVC.self, forCellReuseIdentifier: EditOVERALLContentTVC.id)
        editProgressTableView.register(EditFREEContentTVC.self, forCellReuseIdentifier: EditFREEContentTVC.id)
        editProgressTableView.rowHeight = UITableView.automaticDimension
        editProgressTableView.estimatedRowHeight = 200
        editProgressTableView.backgroundColor = .clear
        editProgressTableView.isScrollEnabled = false
        editProgressTableView.showsVerticalScrollIndicator = false
        
        addButtonStackView.axis = .horizontal
        addButtonStackView.spacing = 14
        addButtonStackView.distribution = .fillEqually
        
        addQNAContentButton.setTitle("+ Q&A 양식", for: .normal)
        addQNAContentButton.setTitleColor(.white, for: .normal)
        addQNAContentButton.layer.cornerRadius = 5
        addQNAContentButton.backgroundColor = .backgroundLightGray
        
        addFreeContentButton.setTitle("+ 자유 양식", for: .normal)
        addFreeContentButton.setTitleColor(.white, for: .normal)
        addFreeContentButton.backgroundColor = .backgroundLightGray
        addFreeContentButton.layer.cornerRadius = 5
        
        deleteButtonBar.isHidden.toggle()
        
        nextButton.setTitle("완료", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor = .backgroundGray
        nextButton.addShadow(.top)
        
        // FIXME: MVP 버전 편집 기능 제거
        statusButtonBar.editButton.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stageTitleCollectionView)
        addSubview(scrollView)
        addSubview(nextButton)
        scrollView.addSubview(statusButtonBar)
        scrollView.addSubview(deleteButtonBar)
        scrollView.addSubview(editProgressTableView)
        scrollView.addSubview(addButtonStackView)
        
        addButtonStackView.addArrangedSubviews([addQNAContentButton, addFreeContentButton])
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
        
        statusButtonBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalTo(self).inset(15)
            $0.height.equalTo(26)
        }
        
        deleteButtonBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalTo(self).inset(15)
            $0.height.equalTo(26)
        }
        
        editProgressTableView.snp.makeConstraints {
            $0.top.equalTo(statusButtonBar.snp.bottom).inset(-16)
            $0.leading.trailing.equalTo(self).inset(16)
            $0.height.equalTo(0)
        }
        
        addButtonStackView.snp.makeConstraints {
            $0.top.equalTo(editProgressTableView.snp.bottom)
            $0.leading.trailing.equalTo(self).inset(16)
            $0.bottom.equalToSuperview().inset(Size.tabBarHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }   
}
