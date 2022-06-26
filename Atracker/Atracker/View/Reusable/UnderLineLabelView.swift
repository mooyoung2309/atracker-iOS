//
//  UnderLineLabelView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import Foundation
import UIKit
import SnapKit

class UnderLineLabelView: BaseView {
    
    var isHighlight: Bool = false {
        didSet(oldValue) {
            if self.isHighlight {
                underLineView.update(.neonGreen)
            } else {
                underLineView.update(.gray3)
            }
        }
    }
    
    let label           = UILabel()
    let underLineView   = Divider(.gray3)
    let button          = UIButton(type: .custom)
    
    override func setupProperty() {
        super.setupProperty()
        
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .gray6
        button.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(label)
        addSubview(underLineView)
        addSubview(button)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(-1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.trailing.equalTo(label)
            $0.width.height.equalTo(18)
        }
    }
}

