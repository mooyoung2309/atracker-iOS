//
//  ReviewDeleteButtonBar.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/14.
//

import UIKit
import SnapKit

class ReviewDeleteButtonBar: BaseView {
    
    let deleteButton        = RoundButton(type: .system)
    let editCompleteButton  = UIButton(type: .system)
    
    override func setupProperty() {
        super.setupProperty()
        
        deleteButton.setTitle("삭제", for: .normal)
        
        editCompleteButton.setTitle("편집 완료", for: .normal)
        editCompleteButton.setTitleColor(.white, for: .normal)
        editCompleteButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(deleteButton)
        addSubview(editCompleteButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        deleteButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(45)
            $0.height.equalTo(26)
        }
        
        editCompleteButton.snp.makeConstraints {
            $0.centerY.equalTo(deleteButton)
            $0.trailing.equalToSuperview()
        }
    }
}
