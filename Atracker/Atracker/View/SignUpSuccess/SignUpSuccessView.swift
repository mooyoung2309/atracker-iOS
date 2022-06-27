//
//  SignUpSuccessView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import UIKit
import SnapKit

class SignUpSuccessView: BaseView {
    
    let gifImageView    = UILabel()
    let titleLabel      = UILabel()
    let messageLabel    = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        gifImageView.text = "3초 뒤에 화면이 이동 됩니다."
        gifImageView.font = .systemFont(ofSize: 15)
        gifImageView.textColor = .white
        
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
        
        addSubview(gifImageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        gifImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
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
