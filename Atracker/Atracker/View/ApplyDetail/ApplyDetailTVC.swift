//
//  ApplyDetailTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/13.
//

import UIKit
import Then
import SnapKit

class ApplyDetailTVC: BaseTVC {
    static let id = "ApplyDetailTVC"
    
    let circle = UIView()
    let titleLabel = UILabel()
    
    let contextLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .clear
        
        circle.backgroundColor      = .neonGreen
        circle.layer.cornerRadius   = 4
        
        titleLabel.text         = "테스트 전형"
        titleLabel.font         = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor    = .white
        
        contextLabel.text           = "다양한 이유가 있겠지만 아마 세일즈 준비를 못한게 컸을거라고 생각한다. '인성/직무 면접, 인사이트 면접' 이라 되어있어서 일반 PT랑 인성 면접이지 않을까 생각했는데 아니였다. 은행을 가본지 10년은 됐니 은행원이 고객서비스를 어떻게 하는지 모르니 세일즈가 진행이 안됐다."
        contextLabel.font           = .systemFont(ofSize: 13, weight: .regular)
        contextLabel.textColor      = .white
        contextLabel.numberOfLines  = 100
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(circle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contextLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(circle.snp.trailing).inset(-6)
            $0.centerY.equalTo(circle)
        }
        
        circle.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(8)
        }
        
        contextLabel.snp.makeConstraints {
            $0.top.equalTo(circle.snp.bottom).inset(-15)
            $0.leading.equalTo(circle)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
