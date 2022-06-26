//
//  SignUpSuccessView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import UIKit
import SnapKit

class SignUpSuccessView: BaseView {
    
    let titleLabel      = UILabel()
    let messageLabel    = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "이소진님,\n반갑습니다!"
        titleLabel.font = .systemFont(ofSize: 26, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        messageLabel.text = "로그인 완료!"
        messageLabel.font = .systemFont(ofSize: 16, weight: .regular)
        messageLabel.textColor = .gray2
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(181)
        }
        
        messageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top).inset(-8)
        }
    }
}
