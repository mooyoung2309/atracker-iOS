//
//  UnderLineTextFieldView.swift
//  Atracker
//
//  Created by 송영모 on 2022/06/27.
//

import Foundation
import UIKit
import SnapKit

class UnderLineTextFieldView: BaseView, UITextFieldDelegate {
    
    let titleLabel      = UILabel()
    let textField       = UITextField()
    let underLineView   = Divider(.gray3)
    let button          = UIButton(type: .custom)
    
    var isHighlight: Bool = false {
        didSet(oldValue) {
            if self.isHighlight {
                underLineView.update(.neonGreen)
            } else {
                underLineView.update(.gray3)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        underLineView.update(.neonGreen)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        underLineView.update(.gray3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.gray6, .font: UIFont.systemFont(ofSize: 16, weight: .light)])
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .gray3
        
        textField.tintColor = .neonGreen
        textField.textColor = .white
        textField.delegate = self
        
        button.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(underLineView)
        addSubview(button)
        addSubview(textField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-3)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField)
            $0.width.height.equalTo(18)
        }
    }
}
