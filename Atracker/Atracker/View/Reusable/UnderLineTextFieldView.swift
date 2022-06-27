//
//  UnderLineTextFieldView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import Foundation
import UIKit
import SnapKit

class UnderLineTextFieldView: BaseView {
    
    var isHighlight: Bool = false {
        didSet(oldValue) {
            if self.isHighlight {
                underLineView.update(.neonGreen)
            } else {
                underLineView.update(.gray3)
            }
        }
    }
    
    let textField       = UITextField()
    let underLineView   = Divider(.gray3)
    let button          = UIButton(type: .custom)
    
    override func setupProperty() {
        super.setupProperty()
        
        button.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(underLineView)
        addSubview(button)
        addSubview(textField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        textField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField)
            $0.width.height.equalTo(18)
        }
    }
}
