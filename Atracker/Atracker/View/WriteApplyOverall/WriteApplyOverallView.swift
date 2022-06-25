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
    
    let companyLabel            = UILabel()
    let companyTextField        = UITextField()
    let companySearchButton     = UIButton(type: .custom)
    let companyDivider          = Divider(.gray6)
    let companySearchTableView  = UITableView()
    let positionLabel           = UILabel()
    let positionTextField       = UITextField()
    let positionDivider         = Divider(.gray6)
    let jobTypeLabel            = UILabel()
    let jobTypeResultLabel      = UILabel()
    let jobTypeButton           = UIButton(type: .custom)
    let jobTypeDivider          = Divider(.gray6)
    let jobSearchTableView      = UITableView()
    let progressLabel           = UILabel()
    let reloadButton            = UIButton(type: .custom)
    let collectionView          = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let nextButton              = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        companyLabel.text                       = "회사명"
        companyLabel.font                       = .systemFont(ofSize: 14, weight: .medium)
        companyLabel.textColor                  = .gray3
        
        companyTextField.textColor              = .white
        companyTextField.attributedPlaceholder = NSAttributedString(string: "회사명을 입력해주세요.", attributes: [.foregroundColor: UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        
        companySearchButton.setBackgroundImage(UIImage(named: ImageName.search)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        companySearchButton.setBackgroundImage(UIImage(named: ImageName.cancle)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .selected)
        
        companySearchTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        companySearchTableView.backgroundColor      = .backgroundLightGray
        companySearchTableView.rowHeight            = UITableView.automaticDimension
        companySearchTableView.estimatedRowHeight   = 50
        
        positionLabel.text                        = "지원 분야"
        positionLabel.font                        = .systemFont(ofSize: 14, weight: .medium)
        positionLabel.textColor                   = .gray3
        
        positionTextField.textColor               = .white
        positionTextField.attributedPlaceholder = NSAttributedString(string: "지원 분야를 입력해주세요.", attributes: [.foregroundColor: UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        
        jobTypeLabel.text                      = "포지션"
        jobTypeLabel.font                      = .systemFont(ofSize: 14, weight: .medium)
        jobTypeLabel.textColor                 = .gray3
        
        jobTypeResultLabel.text         = "근무 형태를 선택해주세요."
        jobTypeResultLabel.font         = .systemFont(ofSize: 16, weight: .light)
        jobTypeResultLabel.textColor    = .gray6
        
        jobTypeButton.setBackgroundImage(UIImage(named: ImageName.checkBottom)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        
        jobSearchTableView.register(SearchTVC.self, forCellReuseIdentifier: SearchTVC.id)
        jobSearchTableView.backgroundColor      = .backgroundLightGray
        jobSearchTableView.rowHeight            = UITableView.automaticDimension
        jobSearchTableView.estimatedRowHeight   = 50
        jobSearchTableView.isScrollEnabled = false
        
        progressLabel.text                      = "지원 단계 순서대로 단계를 눌러주세요."
        progressLabel.font                      = .systemFont(ofSize: 14, weight: .medium)
        progressLabel.textColor                 = .gray3
        
        reloadButton.setImage(UIImage(named: ImageName.reload)?.withTintColor(.gray6, renderingMode: .alwaysOriginal), for: .normal)
        reloadButton.tintColor = .gray6
        
        collectionView.register(WriteApplyOverallCVC.self, forCellWithReuseIdentifier: WriteApplyOverallCVC.id)
        collectionView.backgroundColor = .clear
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.neonGreen, for: .normal)
        nextButton.titleLabel?.font     = .systemFont(ofSize: 16, weight: .regular)
        nextButton.backgroundColor      = .backgroundGray
        nextButton.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(companyLabel)
        addSubview(companyTextField)
        addSubview(companySearchButton)
        addSubview(companyDivider)
        addSubview(positionLabel)
        addSubview(positionTextField)
        addSubview(positionDivider)
        addSubview(jobTypeLabel)
        addSubview(jobTypeResultLabel)
        addSubview(jobTypeButton)
        addSubview(jobTypeDivider)
        addSubview(progressLabel)
        addSubview(reloadButton)
        addSubview(collectionView)
        addSubview(nextButton)
        addSubview(companySearchTableView)
        addSubview(jobSearchTableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        companyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.equalToSuperview().inset(39)
        }
        
        companyTextField.snp.makeConstraints {
            $0.top.equalTo(companyLabel.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalTo(companySearchButton.snp.leading)
        }
        
        companySearchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalTo(companyTextField)
            $0.width.height.equalTo(18)
        }
        
        companyDivider.snp.makeConstraints {
            $0.top.equalTo(companyTextField.snp.bottom).inset(-6)
            $0.leading.equalTo(companyTextField)
            $0.trailing.equalTo(companySearchButton)
        }
        
        companySearchTableView.snp.makeConstraints {
            $0.top.equalTo(companyDivider.snp.bottom)
            $0.leading.trailing.equalTo(companyDivider)
            $0.height.equalTo(0)
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalTo(companyTextField.snp.bottom).inset(-34)
            $0.leading.equalToSuperview().inset(39)
        }
        
        positionTextField.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        positionDivider.snp.makeConstraints {
            $0.top.equalTo(positionTextField.snp.bottom).inset(-6)
            $0.leading.equalTo(positionTextField)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        jobTypeLabel.snp.makeConstraints {
            $0.top.equalTo(positionTextField.snp.bottom).inset(-39)
            $0.leading.equalToSuperview().inset(39)
        }
        
        jobTypeResultLabel.snp.makeConstraints {
            $0.top.equalTo(jobTypeLabel.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        jobTypeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalTo(jobTypeResultLabel)
            $0.width.height.equalTo(18)
        }
        
        jobTypeDivider.snp.makeConstraints {
            $0.top.equalTo(jobTypeResultLabel.snp.bottom).inset(-6)
            $0.leading.trailing.equalTo(jobTypeResultLabel)
        }
        
        jobSearchTableView.snp.makeConstraints {
            $0.top.equalTo(jobTypeDivider.snp.bottom)
            $0.leading.trailing.equalTo(jobTypeDivider)
            $0.height.equalTo(0)
        }
        
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(jobTypeResultLabel.snp.bottom).inset(-39)
            $0.leading.equalToSuperview().inset(39)
        }
        
        reloadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.centerY.equalTo(progressLabel)
            $0.width.height.equalTo(18)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).inset(-25)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(28)
            $0.bottom.equalTo(nextButton.snp.top)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
