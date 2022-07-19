//
//  SearchTVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/23.
//

import UIKit
import SnapKit

class SearchTVC: BaseTVC {
    static let id = "SearchTVC"
    
    let titleLabel = UILabel()
    
    func update(title: String) {
        titleLabel.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .light)
        titleLabel.textColor = .white
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(6)
        }
    }
}
