//
//  MyPageView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/29.
//

import UIKit
import SnapKit

class MyPageView: BaseView {
    
    let welcomeLabel = UILabel()
    let positionTagLabel = UILabel()
    let positionLabel = UILabel()
    let careerTagLabel = UILabel()
    let careerLabel = UILabel()
    let careerDivider = BarChatView(.horizontal, cornerRadius: 0)
    let accountTagLabel = UILabel()
    let accountDivider = Divider(.gray6)
    let signOutButton = UIButton(type: .system)
    let signOutDivider = Divider(.backgroundLightGray)
    let withDrawButton = UIButton(type: .system)
    let withDrawDivider = Divider(.backgroundLightGray)
    let helpTagLabel = UILabel()
    let helpDivider = Divider(.gray6)
    let connectButton = UIButton(type: .system)
    let connectDivider = Divider(.backgroundLightGray)
    
    var nickname = ""
    
    override func setupProperty() {
        super.setupProperty()
        
        welcomeLabel.font = .systemFont(ofSize: 24, weight: .regular)
        welcomeLabel.textColor = .white
        welcomeLabel.numberOfLines = 0
        
        positionTagLabel.text = "포지션"
        positionTagLabel.font = .systemFont(ofSize: 14, weight: .medium)
        positionTagLabel.textColor = .gray3
        
        positionLabel.font = .systemFont(ofSize: 16, weight: .light)
        positionLabel.textColor = .white
        
        careerTagLabel.text = "경력"
        careerTagLabel.font = .systemFont(ofSize: 14, weight: .medium)
        careerTagLabel.textColor = .gray3
        
        careerLabel.font = .systemFont(ofSize: 16, weight: .light)
        careerLabel.textColor = .white
        
        accountTagLabel.text = "계정 설정"
        accountTagLabel.font = .systemFont(ofSize: 16, weight: .light)
        accountTagLabel.textColor = .white
        
        signOutButton.setTitle("로그아웃", for: .normal)
        signOutButton.setTitleColor(.gray3, for: .normal)
        signOutButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        withDrawButton.setTitle("계정 탈퇴", for: .normal)
        withDrawButton.setTitleColor(.gray3, for: .normal)
        withDrawButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        helpTagLabel.text = "도움"
        helpTagLabel.font = .systemFont(ofSize: 16, weight: .light)
        helpTagLabel.textColor = .white
        
        connectButton.setTitle("연락하기", for: .normal)
        connectButton.setTitleColor(.gray3, for: .normal)
        connectButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(welcomeLabel)
        addSubview(positionTagLabel)
        addSubview(positionLabel)
        addSubview(careerTagLabel)
        addSubview(careerLabel)
        addSubview(careerDivider)
        addSubview(accountTagLabel)
        addSubview(accountDivider)
        addSubview(signOutButton)
        addSubview(signOutDivider)
        addSubview(withDrawButton)
        addSubview(withDrawDivider)
        addSubview(helpTagLabel)
        addSubview(helpDivider)
        addSubview(connectButton)
        addSubview(connectDivider)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        positionTagLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).inset(-26)
            $0.leading.equalToSuperview().inset(32)
        }
        
        positionLabel.snp.makeConstraints {
            $0.leading.equalTo(positionTagLabel.snp.trailing).inset(-23)
            $0.centerY.equalTo(positionTagLabel)
        }
        
        careerTagLabel.snp.makeConstraints {
            $0.top.equalTo(positionTagLabel.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(32)
        }
        
        careerLabel.snp.makeConstraints {
            $0.leading.equalTo(positionLabel)
            $0.centerY.equalTo(careerTagLabel)
        }
        
        careerDivider.snp.makeConstraints {
            $0.top.equalTo(careerLabel.snp.bottom).inset(-35)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        accountTagLabel.snp.makeConstraints {
            $0.top.equalTo(careerDivider.snp.bottom).inset(-40)
            $0.leading.equalToSuperview().inset(28)
        }
        
        accountDivider.snp.makeConstraints {
            $0.top.equalTo(accountTagLabel.snp.bottom).inset(-13)
            $0.leading.trailing.equalToSuperview()
        }
        
        signOutButton.snp.makeConstraints {
            $0.top.equalTo(accountDivider.snp.bottom).inset(-13)
            $0.leading.equalToSuperview().inset(28)
        }
        
        signOutDivider.snp.makeConstraints {
            $0.top.equalTo(signOutButton.snp.bottom).inset(-13)
            $0.leading.trailing.equalToSuperview()
        }
        
        withDrawButton.snp.makeConstraints {
            $0.top.equalTo(signOutDivider.snp.bottom).inset(-13)
            $0.leading.equalToSuperview().inset(28)
        }
        
        withDrawDivider.snp.makeConstraints {
            $0.top.equalTo(withDrawButton.snp.bottom).inset(-13)
            $0.leading.trailing.equalToSuperview()
        }
        
        helpTagLabel.snp.makeConstraints {
            $0.top.equalTo(withDrawDivider.snp.bottom).inset(-32)
            $0.leading.equalToSuperview().inset(28)
        }
        
        helpDivider.snp.makeConstraints {
            $0.top.equalTo(helpTagLabel.snp.bottom).inset(-13)
            $0.leading.trailing.equalToSuperview()
        }
        
        connectButton.snp.makeConstraints {
            $0.top.equalTo(helpDivider.snp.bottom).inset(-13)
            $0.leading.equalToSuperview().inset(28)
        }
        
        connectDivider.snp.makeConstraints {
            $0.top.equalTo(connectButton.snp.bottom).inset(-13)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
