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
    
    let titleLabel      = UILabel()
    let contentLabel    = UILabel()
    let underLineView   = Divider(.gray3)
    let button          = UIButton(type: .custom)
    
    let placeholder: String
    
    var isHighlight: Bool = false {
        didSet(oldValue) {
            if self.isHighlight {
                underLineView.update(.neonGreen)
            } else {
                underLineView.update(.gray3)
            }
        }
    }
    
    var contentText: String = "" {
        didSet(oldValue) {
            if self.contentText.isEmpty {
                contentLabel.text = placeholder
                contentLabel.textColor = .gray6
            } else {
                contentLabel.text = self.contentText
                contentLabel.textColor = .white
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }
    
    init(title: String, placeholder: String) {
        self.placeholder = placeholder
        
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        self.contentLabel.text = placeholder
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .gray3
        
        contentLabel.font = .systemFont(ofSize: 16, weight: .light)
        contentLabel.textColor = .gray6
        
        button.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(underLineView)
        addSubview(button)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).inset(-3)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(contentLabel)
            $0.trailing.equalTo(contentLabel)
            $0.width.height.equalTo(18)
        }
    }
}

