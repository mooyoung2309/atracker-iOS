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
    
    let circle = UIView().then {
        $0.backgroundColor = .neonGreen
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
    }
    
    let contextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .white
        $0.numberOfLines = 100
    }
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(circle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contextLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        circle.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(circle.snp.trailing).inset(6)
            $0.centerY.equalTo(circle)
        }
        
        contextLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
}
