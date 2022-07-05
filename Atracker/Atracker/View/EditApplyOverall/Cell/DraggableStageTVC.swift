//
//  DraggableStageTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/05.
//

import UIKit
import SnapKit

class DraggableStageTVC: BaseTVC {
    
    static let id = "DraggableStageTVC"
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let cancleButton = UIButton()
    
    func update(title: String) {
        titleLabel.text = title
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .clear
        
        containerView.backgroundColor = .backgroundLightGray
        
        titleLabel.text = "사전 과제"
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .white
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(cancleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(1)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(13)
        }
    }
}
