//
//  BottomNextButtonView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import Foundation
import UIKit

class BottomNextButtonView: BaseView {
    
    let button = UIButton(type: .custom)
    
    override func setupProperty() {
        super.setupProperty()
        
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.neonGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(button)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
