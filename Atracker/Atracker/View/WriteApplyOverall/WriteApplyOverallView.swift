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
    let companySearchButton     = UIButton(type: .system)
    let companyDivider          = Divider(.gray6)
    let objectLabel             = UILabel()
    let objectTextField         = UITextField()
    let objectSearchButton      = UIButton(type: .system)
    let objectDivider           = Divider(.gray6)
    let positionLabel           = UILabel()
    let positionTextField       = UITextField()
    let positionDivider         = Divider(.gray6)
    let progressLabel           = UILabel()
    let resetButton             = UIButton(type: .system)
    let collectionView          = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let nextButton              = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        companyLabel.text                       = "회사명"
        companyLabel.font                       = .systemFont(ofSize: 14, weight: .medium)
        companyLabel.textColor                  = .gray3
        
        companyTextField.textColor              = .white
        companyTextField.attributedPlaceholder = NSAttributedString(string: "회사명을 입력해주세요.", attributes: [.foregroundColor: UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        
        companySearchButton.setImage(UIImage(named: ImageName.search), for: .normal)
        companySearchButton.tintColor = .gray6
        
        objectLabel.text                        = "지원 분야"
        objectLabel.font                        = .systemFont(ofSize: 14, weight: .medium)
        objectLabel.textColor                   = .gray3
        
        objectTextField.textColor               = .white
        objectTextField.attributedPlaceholder = NSAttributedString(string: "지원 분야를 입력해주세요.", attributes: [.foregroundColor: UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        
        objectSearchButton.setImage(UIImage(named: ImageName.search), for: .normal)
        objectSearchButton.tintColor = .gray6
        
        positionLabel.text                      = "포지션"
        positionLabel.font                      = .systemFont(ofSize: 14, weight: .medium)
        positionLabel.textColor                 = .gray3
        
        positionTextField.attributedPlaceholder = NSAttributedString(string: "포지션명을 입력해주세요.", attributes: [.foregroundColor: UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        positionTextField.textColor             = .white
        
        progressLabel.text                      = "지원 단계 순서대로 단계를 눌러주세요."
        progressLabel.font                      = .systemFont(ofSize: 14, weight: .medium)
        progressLabel.textColor                 = .gray3
        
        resetButton.setImage(UIImage(named: ImageName.undo), for: .normal)
        resetButton.tintColor = .white
        
        collectionView.register(WriteApplyOverallCVC.self, forCellWithReuseIdentifier: WriteApplyOverallCVC.id)
        collectionView.backgroundColor = .clear
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
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
        addSubview(objectLabel)
        addSubview(objectTextField)
        addSubview(objectSearchButton)
        addSubview(objectDivider)
        addSubview(positionLabel)
        addSubview(positionTextField)
        addSubview(positionDivider)
        addSubview(progressLabel)
        addSubview(resetButton)
        addSubview(collectionView)
        addSubview(nextButton)
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
        
        objectLabel.snp.makeConstraints {
            $0.top.equalTo(companyTextField.snp.bottom).inset(-34)
            $0.leading.equalToSuperview().inset(39)
        }
        
        objectTextField.snp.makeConstraints {
            $0.top.equalTo(objectLabel.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalTo(objectSearchButton.snp.leading)
        }
        
        objectSearchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalTo(objectTextField)
            $0.width.height.equalTo(18)
        }
        
        objectDivider.snp.makeConstraints {
            $0.top.equalTo(objectTextField.snp.bottom).inset(-6)
            $0.leading.equalTo(objectTextField)
            $0.trailing.equalTo(objectSearchButton)
        }
        
        positionLabel.snp.makeConstraints {
            $0.top.equalTo(objectTextField.snp.bottom).inset(-39)
            $0.leading.equalToSuperview().inset(39)
        }
        
        positionTextField.snp.makeConstraints {
            $0.top.equalTo(positionLabel.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        positionDivider.snp.makeConstraints {
            $0.top.equalTo(positionTextField.snp.bottom).inset(-6)
            $0.leading.trailing.equalTo(positionTextField)
        }
        
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(positionTextField.snp.bottom).inset(-39)
            $0.leading.equalToSuperview().inset(39)
        }
        
        resetButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28)
            $0.centerY.equalTo(progressLabel)
            $0.width.height.equalTo(13)
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
