//
//  SignOutView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation
import UIKit
import SnapKit

class SignOutView: BaseView {
    let googleLoginButton   = UIButton(type: .system)
    let appleLoginButton    = UIButton(type: .system)
    let testLoginButton     = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        testLoginButton.backgroundColor     = .backgroundLightGray
        testLoginButton.layer.borderWidth   = 1
        testLoginButton.layer.borderColor   = UIColor.gray7.cgColor
        testLoginButton.layer.cornerRadius  = 25
        testLoginButton.setTitle("테스트용 백도어 로그인 버튼", for: .normal)
        testLoginButton.setTitleColor(.white, for: .normal)
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(testLoginButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        testLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview()
        }
    }
}
