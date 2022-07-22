//
//  SignUpSuccessView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import UIKit
import SnapKit

class SignUpSuccessView: BaseView {
    
    let imageView = UIImageView(image: UIImage(named: ImageName.logoImage))
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
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
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(274)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(88)
            $0.height.equalTo(91)
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
