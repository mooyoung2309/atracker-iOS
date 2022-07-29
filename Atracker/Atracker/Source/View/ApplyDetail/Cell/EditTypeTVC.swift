//
//  EditTypeTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/07/04.
//

import UIKit
import SnapKit

class EditTypeTVC: BaseTVC {
    static let id = "EditTypeTVC"
    
    let titleImageView = UIImageView()
    let titleLabel = UILabel()
    
    func update(editTypeItem: EditTypeItem) {
        titleImageView.image = UIImage(named: editTypeItem.imageName) 
        titleLabel.text = editTypeItem.title
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .backgroundLightGray
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .white
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(titleImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleImageView.snp.trailing).inset(-20)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
