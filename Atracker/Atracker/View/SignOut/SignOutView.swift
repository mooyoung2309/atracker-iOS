//
//  SignOutView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/24.
//

import Foundation
import UIKit
import SnapKit
import AuthenticationServices

class SignOutView: BaseView {
    
    let googleSignUpButton = UIButton(type: .custom)
    let appleSignUpButton = ASAuthorizationAppleIDButton()
    let testSignUpButton = UIButton(type: .custom)
    
    override func setupProperty() {
        super.setupProperty()
        
        googleSignUpButton.backgroundColor    = .backgroundLightGray
        googleSignUpButton.layer.borderWidth  = 1
        googleSignUpButton.layer.borderColor  = UIColor.gray7.cgColor
        googleSignUpButton.layer.cornerRadius = 25
        googleSignUpButton.setTitle("  Google로 시작하기", for: .normal)
        googleSignUpButton.setImage(UIImage(named: ImageName.google), for: .normal)
        
//        appleSignUpButton.backgroundColor     = .backgroundLightGray
//        appleSignUpButton.layer.borderWidth   = 1
//        appleSignUpButton.layer.borderColor   = UIColor.gray7.cgColor
//        appleSignUpButton.layer.cornerRadius  = 25
//        appleSignUpButton.setTitle("  Apple로 시작하기", for: .normal)
//        appleSignUpButton.setImage(UIImage(named: ImageName.apple), for: .normal)
        
        testSignUpButton.backgroundColor     = .backgroundLightGray
        testSignUpButton.layer.borderWidth   = 1
        testSignUpButton.layer.borderColor   = UIColor.gray7.cgColor
        testSignUpButton.layer.cornerRadius  = 25
        testSignUpButton.setTitle("  Test로 시작하기", for: .normal)
        testSignUpButton.setImage(UIImage(named: ImageName.apple), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(googleSignUpButton)
        addSubview(appleSignUpButton)
        addSubview(testSignUpButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        googleSignUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(52)
            $0.bottom.equalTo(appleSignUpButton.snp.top).inset(-16)
        }
        
        appleSignUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(52)
            $0.bottom.equalTo(testSignUpButton.snp.top).inset(-16)
        }
        
        testSignUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(63)
        }
    }
}
