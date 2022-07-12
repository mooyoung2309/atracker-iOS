//
//  ApplyWriteView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/19.
//

import Foundation
import UIKit
import SnapKit

class WriteApplyOverallView: BaseView {
    
    let companyLabel = UILabel()
    let companyUnderLineTextFieldView = UnderLineTextFieldView(title: "회사명", placeholder: "회사명을 입력해주세요.")
    let companySearchTableView = UITableView()
    let positionUnderLineTextFieldView = UnderLineTextFieldView(title: "포지션", placeholder: "포지션명을 입력해주세요.")
    let jobTypeUnderLineLabelView = UnderLineLabelView(title: "근무형태", placeholder: "근무형태를 선택해주세요.")
    let jobSearchTableView = UITableView()
    let progressLabel = UILabel()
    let reloadButton = UIButton(type: .custom)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let nextButton = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        companyLabel.text = "회사명"
        companyLabel.font = .systemFont(ofSize: 14, weight: .medium)
        companyLabel.textColor = .gray3
        
        companyUnderLineTextFieldView.button.setBackgroundImage(UIImage(named: ImageName.search)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        companyUnderLineTextFieldView.button.setBackgroundImage(UIImage(named: ImageName.cancle)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .selected)
        companyUnderLineTextFieldView.button.isHidden = false
        
        companySearchTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        companySearchTableView.backgroundColor = .backgroundLightGray
        companySearchTableView.rowHeight = UITableView.automaticDimension
        companySearchTableView.estimatedRowHeight = 50
        
        jobTypeUnderLineLabelView.button.setBackgroundImage(UIImage(named: ImageName.checkBottom)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        jobTypeUnderLineLabelView.button.isHidden = false
        
        jobSearchTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        jobSearchTableView.backgroundColor = .backgroundLightGray
        jobSearchTableView.rowHeight = UITableView.automaticDimension
        jobSearchTableView.estimatedRowHeight = 50
        jobSearchTableView.isScrollEnabled = false
        
        progressLabel.text = "지원 단계 순서대로 단계를 눌러주세요."
        progressLabel.font = .systemFont(ofSize: 14, weight: .medium)
        progressLabel.textColor = .gray3
        
        reloadButton.setImage(UIImage(named: ImageName.reload)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        reloadButton.tintColor = .gray6
        
        collectionView.register(WriteApplyOverallCVC.self, forCellWithReuseIdentifier: WriteApplyOverallCVC.id)
        collectionView.backgroundColor = .clear
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor = .backgroundGray
        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(companyUnderLineTextFieldView)
        addSubview(positionUnderLineTextFieldView)
        addSubview(jobTypeUnderLineLabelView)
        addSubview(progressLabel)
        addSubview(reloadButton)
        addSubview(collectionView)
        addSubview(nextButton)
        addSubview(jobSearchTableView)
        addSubview(companySearchTableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        companyUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        companySearchTableView.snp.makeConstraints {
            $0.top.equalTo(companyUnderLineTextFieldView.snp.bottom)
            $0.leading.trailing.equalTo(companyUnderLineTextFieldView)
            $0.height.equalTo(0)
        }
        
        positionUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalTo(companyUnderLineTextFieldView.snp.bottom).inset(-34)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        jobTypeUnderLineLabelView.snp.makeConstraints {
            $0.top.equalTo(positionUnderLineTextFieldView.snp.bottom).inset(-39)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        jobSearchTableView.snp.makeConstraints {
            $0.top.equalTo(jobTypeUnderLineLabelView.snp.bottom)
            $0.leading.trailing.equalTo(jobTypeUnderLineLabelView)
            $0.height.equalTo(0)
        }
        
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(jobTypeUnderLineLabelView.snp.bottom).inset(-39)
            $0.leading.equalToSuperview().inset(28)
        }
        
        reloadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.centerY.equalTo(progressLabel)
            $0.width.height.equalTo(18)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).inset(-25)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.equalTo(nextButton.snp.top)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
