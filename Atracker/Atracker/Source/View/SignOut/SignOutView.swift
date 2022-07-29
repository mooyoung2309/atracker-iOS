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
    
    let imageView = UIImageView(image: UIImage(named: ImageName.splashImage))
    let titleLabel = UILabel()
    let googleSignUpButton = UIButton(type: .custom)
    let appleSignUpButton = ASAuthorizationAppleIDButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "취업 프로세스 기록을\n더 쉽고, 가치있게"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray1
        
        googleSignUpButton.backgroundColor    = .backgroundLightGray
        googleSignUpButton.layer.cornerRadius = 25
        googleSignUpButton.setTitle("  Sign in with Google", for: .normal)
        googleSignUpButton.setImage(UIImage(named: ImageName.google), for: .normal)
        
//        appleSignUpButton.backgroundColor     = .backgroundLightGray
//        appleSignUpButton.layer.borderWidth   = 1
//        appleSignUpButton.layer.borderColor   = UIColor.gray7.cgColor
//        appleSignUpButton.layer.cornerRadius  = 25
        appleSignUpButton.cornerRadius = 25
//        appleSignUpButton.setTitle("  Apple로 시작하기", for: .normal)
//        appleSignUpButton.setImage(UIImage(named: ImageName.apple), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(googleSignUpButton)
        addSubview(appleSignUpButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(250)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(212)
            $0.height.equalTo(27)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(-24)
            $0.centerX.equalToSuperview()
        }
        
        appleSignUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(52)
            $0.bottom.equalTo(googleSignUpButton.snp.top).inset(-16)
        }
        
        googleSignUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(63)
        }
    }
}
