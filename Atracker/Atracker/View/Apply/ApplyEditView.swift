//
//  ApplyEditView.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/30.
//

import UIKit

class ApplyEditView: BaseView {
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.register(ApplyContentTypeCVC.self, forCellWithReuseIdentifier: ApplyContentTypeCVC.id)
        $0.backgroundColor = .backgroundGray
        $0.showsHorizontalScrollIndicator = false
    }
    let contentTypeButtonStackView = UIStackView().then {
        $0.spacing = 8
    }
    let tableView = UITableView().then {
        $0.register(ApplyContentTVC.self, forCellReuseIdentifier: ApplyContentTVC.id)
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .backgroundGray
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.isScrollEnabled = false
    }
    
    let awiatButton = FixSizedRoundButton(size: CGSize(width: 65, height: 26), round: 13, title: "대기중", backgroundColor: .backgroundGray, tintColor: .gray3, selectedColor: .red)
    let failButton = FixSizedRoundButton(size: CGSize(width: 65, height: 26), round: 13, title: "불합격", backgroundColor: .backgroundGray, tintColor: .gray3, selectedColor: .red)
    let passButton = FixSizedRoundButton(size: CGSize(width: 65, height: 26), round: 13, title: "합격", backgroundColor: .backgroundGray, tintColor: .gray3, selectedColor: .red)
    let editButton = TextButton("편집", selectedColor: .white)
    
    let plusButtonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 14
    }
    
    let deleteButton = FixSizedRoundButton(size: CGSize(width: 65, height: 26), round: 13, title: "삭제", backgroundColor: .backgroundGray, tintColor: .gray3, selectedColor: .red)
    let upButton = FixSizedRoundButton(size: CGSize(width: 26, height: 26), round: 13, image: UIImage(systemName: "chevron.up"), backgroundColor: .backgroundGray, tintColor: .gray3, selectedColor: .red)
    let downButton = FixSizedRoundButton(size: CGSize(width: 26, height: 26), round: 13, image: UIImage(systemName: "chevron.down"), backgroundColor: .backgroundGray, tintColor: .gray3, selectedColor: .red)
    let deleteButtonStackView = UIStackView().then {
        $0.spacing = 8
    }
    let plusQAButton = BoxButton("+ 질의응답", selectedColor: .white)
    let plusReviewButton = BoxButton("+ 종합후기", selectedColor: .white)
    
    override func setupProperty() {
        super.setupProperty()
        contentTypeButtonStackView.addArrangedSubviews([awiatButton, failButton, passButton])
        deleteButtonStackView.addArrangedSubviews([deleteButton, upButton, downButton])
        plusButtonStackView.addArrangedSubviews([plusQAButton, plusReviewButton])
        
        deleteButtonStackView.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(collectionView)
        addSubview(scrollView)
        addSubview(contentTypeButtonStackView)
        addSubview(deleteButtonStackView)
        addSubview(editButton)
        scrollView.addSubview(tableView)
        scrollView.addSubview(plusButtonStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        contentTypeButtonStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.equalTo(tableView.snp.leading)
        }
        
        deleteButtonStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.equalTo(tableView.snp.leading)
        }
        
        editButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalTo(contentTypeButtonStackView.snp.centerY)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(contentTypeButtonStackView.snp.bottom).inset(-17)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(-16)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(0)
        }
        
        plusButtonStackView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(-16)
            $0.bottom.equalToSuperview()
        }
    }
}
