//
//  SignUpNicknameView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation
import UIKit
import SnapKit

class SignUpNicknameView: BaseView {
    
    let titleLabel                      = UILabel()
    let nicknameUnderLineTextFieldView  = UnderLineTextFieldView(title: "이름", placeholder: "이름을 입력해주세요.")
    let bottomNextButtonView            = BottomNextButtonView()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text         = "개성있는 닉네임을 설정해주세요."
        titleLabel.font         = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor    = .white
        
        nicknameUnderLineTextFieldView.textField.textColor = .white
        nicknameUnderLineTextFieldView.textField.tintColor = .neonGreen
        
        bottomNextButtonView.backgroundColor = .backgroundGray
        bottomNextButtonView.addShadow(.top)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(nicknameUnderLineTextFieldView)
        addSubview(bottomNextButtonView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        nicknameUnderLineTextFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        bottomNextButtonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Size.tabBarHeight)
        }
    }
}
