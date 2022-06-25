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
    
    let titleLabel          = UILabel()
    let nicknameLabel       = UILabel()
    let nicknameTextField   = UITextField()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "개성있는 닉네임을 설정해주세요."
        nicknameLabel.text = "이름"
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(37)
            $0.leading.equalToSuperview().inset(28)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel).inset(16)
            $0.leading.equalToSuperview().inset(28)
        }
    }
}
