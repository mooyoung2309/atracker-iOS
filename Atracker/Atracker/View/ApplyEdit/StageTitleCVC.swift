//
//  StageCVC.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import UIKit
import SnapKit
import Then

class StageTitleCVC: BaseCVC {
    static let id = "StageTitleCVC"
    
    let titleLabel = UILabel()
    let bottomBarView = UIView()
    
    func update(title: String) {
        titleLabel.text = title
    }
    
    func hightlight() {
        titleLabel.textColor    = .white
        bottomBarView.alpha     = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.textColor    = .gray3
        bottomBarView.alpha     = 0
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font                     = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor                = .gray3
        titleLabel.textAlignment            = .center
        
        bottomBarView.backgroundColor       = .white
        bottomBarView.layer.cornerRadius    = 1
        bottomBarView.alpha                 = 0
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomBarView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        bottomBarView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
